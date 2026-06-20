defmodule Mix.UOF.XSD do
  @moduledoc """
  A small XSD parser that turns Betradar's `.xsd` files into a flat
  intermediate representation (a list of `ComplexType`s plus the root
  elements), suitable for code generation.

  It deliberately supports only the XSD subset Betradar uses:
  `xs:complexType`, `xs:sequence`/`xs:choice`/`xs:all`, `xs:element`,
  `xs:attribute`, and `xs:complexContent` > `xs:extension`. Includes are
  resolved by simply parsing every file handed in and merging the result;
  duplicate type names are de-duplicated by name.
  """

  defmodule Attribute do
    @moduledoc false
    defstruct [:name, :type, required: false]
  end

  defmodule Element do
    @moduledoc false
    # max is an integer or :unbounded
    defstruct [:name, :type, min: 1, max: 1]
  end

  defmodule ComplexType do
    @moduledoc false
    # attribute_groups holds names of referenced xs:attributeGroups, expanded
    # into attributes during parse_files/1.
    defstruct [:name, base: nil, attributes: [], elements: [], attribute_groups: []]
  end

  defmodule AttributeGroup do
    @moduledoc false
    defstruct [:name, attributes: [], attribute_groups: []]
  end

  defmodule SimpleType do
    @moduledoc false
    # base is the local name of the xs:restriction base (nil for union/list).
    defstruct [:name, :base]
  end

  defmodule Root do
    @moduledoc false
    defstruct [:name, :type]
  end

  @doc "Parse and merge a list of XSD file paths into `{types, roots}`."
  def parse_files(paths) do
    nodes = Enum.flat_map(paths, &parse_file/1)

    types = nodes |> Enum.filter(&match?(%ComplexType{}, &1)) |> Enum.uniq_by(& &1.name)
    roots = Enum.filter(nodes, &match?(%Root{}, &1))
    groups = nodes |> Enum.filter(&match?(%AttributeGroup{}, &1)) |> Map.new(&{&1.name, &1})

    simple_types =
      nodes |> Enum.filter(&match?(%SimpleType{}, &1)) |> Map.new(&{&1.name, &1.base})

    types =
      types
      |> resolve_attribute_groups(groups)
      |> resolve_simple_types(simple_types)

    {types, roots}
  end

  # Replace references to named simpleTypes with their underlying xs base type,
  # so a field typed e.g. `outcomeActive` (restriction of xs:int) becomes an
  # integer instead of falling back to a string. complexType/primitive
  # references are left untouched.
  defp resolve_simple_types(types, simple_types) do
    Enum.map(types, fn type ->
      %{
        type
        | attributes: Enum.map(type.attributes, &resolve_field_type(&1, simple_types)),
          elements: Enum.map(type.elements, &resolve_field_type(&1, simple_types))
      }
    end)
  end

  defp resolve_field_type(field, simple_types) do
    %{field | type: resolve_type(field.type, simple_types, MapSet.new())}
  end

  defp resolve_type(type, simple_types, seen) do
    cond do
      type in seen -> type
      not Map.has_key?(simple_types, type) -> type
      # union/list simpleType (no single base) -> leave for the string fallback
      is_nil(Map.get(simple_types, type)) -> type
      true -> resolve_type(Map.fetch!(simple_types, type), simple_types, MapSet.put(seen, type))
    end
  end

  # Expand each complexType's referenced attributeGroups into plain attributes.
  defp resolve_attribute_groups(types, groups) do
    Enum.map(types, fn type ->
      extra = Enum.flat_map(type.attribute_groups, &group_attributes(&1, groups, MapSet.new()))
      %{type | attributes: type.attributes ++ extra, attribute_groups: []}
    end)
  end

  defp group_attributes(name, groups, seen) do
    cond do
      MapSet.member?(seen, name) ->
        []

      group = Map.get(groups, name) ->
        # attributeGroups may themselves reference other groups
        nested =
          Enum.flat_map(
            group.attribute_groups || [],
            &group_attributes(&1, groups, MapSet.put(seen, name))
          )

        group.attributes ++ nested

      true ->
        []
    end
  end

  @doc "Parse a single XSD file into a flat list of `ComplexType`/`Root` nodes."
  def parse_file(path) do
    {:ok, {"xs:schema", _attrs, children}} =
      path |> File.read!() |> Saxy.SimpleForm.parse_string()

    children
    |> elements()
    |> Enum.flat_map(&top_level_node/1)
  end

  @doc """
  Resolve root *element* names to their complexType names, using the `roots`
  returned by `parse_files/1`. Raises on an unknown element name (catches typos
  in a group's allow-list).
  """
  def root_types(roots, element_names) do
    by_name = Map.new(roots, &{&1.name, &1.type})

    Enum.map(element_names, fn name ->
      Map.get(by_name, name) ||
        raise ArgumentError,
              "unknown root element #{inspect(name)}; available: " <>
                inspect(Enum.map(roots, & &1.name))
    end)
  end

  @doc """
  Filter `types` to those reachable from `root_type_names`, following element
  type references and `xs:extension` bases. Lets generation be scoped to the
  endpoints actually in use instead of every complexType in the schema set.
  """
  def reachable_types(types, root_type_names) do
    registry = Map.new(types, &{&1.name, &1})
    seen = collect(root_type_names, registry, MapSet.new())
    Enum.filter(types, &MapSet.member?(seen, &1.name))
  end

  defp collect([], _registry, seen), do: seen

  defp collect([name | rest], registry, seen) do
    case Map.get(registry, name) do
      nil ->
        # primitive or externally-defined type; nothing to walk
        collect(rest, registry, seen)

      %ComplexType{} = type ->
        if MapSet.member?(seen, name) do
          collect(rest, registry, seen)
        else
          collect(type_refs(type) ++ rest, registry, MapSet.put(seen, name))
        end
    end
  end

  defp type_refs(%ComplexType{base: base, elements: elements}) do
    [base | Enum.map(elements, & &1.type)] |> Enum.reject(&is_nil/1)
  end

  ## Top-level nodes ---------------------------------------------------------

  defp top_level_node({"xs:complexType", attrs, children}) do
    name = attr(attrs, "name")
    {type, nested} = parse_complex_type(name, children, camelize(name))
    [type | nested]
  end

  defp top_level_node({"xs:element", attrs, children}) do
    name = attr(attrs, "name")

    case {attr(attrs, "type"), inline_complex_type(children)} do
      {type, _} when is_binary(type) ->
        [%Root{name: name, type: local(type)}]

      {nil, {_t, _a, ct_children}} ->
        synth = camelize(name)
        {type, nested} = parse_complex_type(synth, ct_children, synth)
        [%Root{name: name, type: synth}, type | nested]

      {nil, nil} ->
        []
    end
  end

  defp top_level_node({"xs:simpleType", attrs, children}) do
    [%SimpleType{name: attr(attrs, "name"), base: simple_type_base(children)}]
  end

  defp top_level_node({"xs:attributeGroup", attrs, children}) do
    nodes = elements(children)

    [
      %AttributeGroup{
        name: attr(attrs, "name"),
        attributes: parse_attributes(nodes),
        attribute_groups: attribute_group_refs(nodes)
      }
    ]
  end

  defp top_level_node(_other), do: []

  ## complexType -------------------------------------------------------------

  # Returns `{complex_type, nested_synthesized_types}`. `prefix` (PascalCase)
  # seeds names for anonymous types defined on this type's elements.
  defp parse_complex_type(name, children, prefix) do
    {base, content} = unwrap_extension(elements(children))
    {parsed_elements, nested} = parse_elements(content, prefix)

    type = %ComplexType{
      name: name,
      base: base,
      attributes: parse_attributes(content),
      attribute_groups: attribute_group_refs(content),
      elements: parsed_elements
    }

    {type, nested}
  end

  defp inline_complex_type(children) do
    children |> elements() |> Enum.find(&tag?(&1, "xs:complexType"))
  end

  # Local base name of a simpleType's xs:restriction (nil for union/list).
  defp simple_type_base(children) do
    case children |> elements() |> Enum.find(&tag?(&1, "xs:restriction")) do
      {"xs:restriction", attrs, _children} -> local(attr(attrs, "base"))
      _ -> nil
    end
  end

  defp attribute_group_refs(nodes) do
    for {"xs:attributeGroup", attrs, _c} <- nodes,
        ref = attr(attrs, "ref"),
        ref != nil,
        do: local(ref)
  end

  # xs:complexContent > xs:extension(base) hoists the extension's children up
  # and records the base type so the generator can flatten it.
  defp unwrap_extension(nodes) do
    case Enum.find(nodes, &tag?(&1, "xs:complexContent")) do
      {"xs:complexContent", _a, cc_children} ->
        case Enum.find(elements(cc_children), &tag?(&1, "xs:extension")) do
          {"xs:extension", ext_attrs, ext_children} ->
            {local(attr(ext_attrs, "base")), elements(ext_children)}

          _ ->
            {nil, nodes}
        end

      _ ->
        {nil, nodes}
    end
  end

  defp parse_attributes(nodes) do
    nodes
    |> Enum.filter(&tag?(&1, "xs:attribute"))
    |> Enum.map(fn {_t, attrs, _c} ->
      %Attribute{
        name: attr(attrs, "name"),
        type: local(attr(attrs, "type")),
        required: attr(attrs, "use") == "required"
      }
    end)
  end

  # Elements live inside xs:sequence / xs:choice / xs:all (possibly nested).
  # Returns `{elements, synthesized_types}`; synthesized types come from
  # elements declared with an inline (anonymous) complexType.
  defp parse_elements(nodes, prefix) do
    nodes
    |> Enum.flat_map_reduce([], fn node, synth ->
      case node do
        {tag, _a, children} when tag in ["xs:sequence", "xs:choice", "xs:all"] ->
          {nested_elements, nested_synth} = parse_elements(elements(children), prefix)
          {nested_elements, synth ++ nested_synth}

        {"xs:element", attrs, children} ->
          {element, element_synth} = parse_element(attrs, children, prefix)
          {[element], synth ++ element_synth}

        _ ->
          {[], synth}
      end
    end)
  end

  defp parse_element(attrs, children, prefix) do
    name = attr(attrs, "name")
    min = to_int(attr(attrs, "minOccurs"), 1)
    max = parse_max(attr(attrs, "maxOccurs"))

    {type, synth} =
      case {attr(attrs, "type"), inline_complex_type(children)} do
        {type, _} when is_binary(type) ->
          {local(type), []}

        {nil, {_t, _a, ct_children}} ->
          synth_name = prefix <> camelize(name)
          {ct, nested} = parse_complex_type(synth_name, ct_children, synth_name)
          {synth_name, [ct | nested]}

        {nil, nil} ->
          # element with an inline simpleType or no type at all -> scalar string
          {"string", []}
      end

    {%Element{name: name, type: type, min: min, max: max}, synth}
  end

  ## helpers -----------------------------------------------------------------

  defp elements(children), do: Enum.filter(children, &is_tuple/1)

  defp tag?({tag, _a, _c}, tag), do: true
  defp tag?(_node, _tag), do: false

  defp attr(attrs, key) do
    case List.keyfind(attrs, key, 0) do
      {^key, value} -> value
      nil -> nil
    end
  end

  # Drop any namespace prefix from a QName ("tns:EventType" -> "EventType").
  defp local(nil), do: nil

  defp local(qname) do
    case String.split(qname, ":", parts: 2) do
      [_prefix, name] -> name
      [name] -> name
    end
  end

  defp camelize(name), do: Macro.camelize(name)

  defp parse_max(nil), do: 1
  defp parse_max("unbounded"), do: :unbounded
  defp parse_max(n), do: String.to_integer(n)

  defp to_int(nil, default), do: default
  defp to_int(n, _default), do: String.to_integer(n)
end
