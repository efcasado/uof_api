defmodule Mix.UOF.XSD.Generator do
  @moduledoc """
  Turns the `UOF.XSD` intermediate representation into Ecto embedded-schema
  source code (one module per `complexType`), mirroring the XSD nesting
  faithfully.

  Design decisions (see project memory):

    * `xs:decimal` and the odds/probability fields -> `Ecto.Decimal`
    * date/time fields -> `:date` / `:utc_datetime`
    * field names follow the XSD, except for entries in `@rename_overrides`
  """

  alias Mix.UOF.XSD.{Attribute, ComplexType, Element}

  # Per field-name type overrides applied on top of the XSD type mapping.
  @type_overrides %{
    "odds" => :decimal,
    "probability" => :decimal,
    "generated_at" => :utc_datetime
  }

  # XSD element/attribute name -> generated struct field name.
  @rename_overrides %{}

  @doc """
  Generate source for every `ComplexType` in `types`.

  Returns a list of `{short_name, source}` tuples where `short_name` is the
  module name relative to `namespace` (e.g. `"Event"`).
  """
  def generate(types, namespace) do
    registry = Map.new(types, &{&1.name, &1})
    Enum.map(types, &{short_name(&1.name), render(&1, namespace, registry)})
  end

  ## rendering ---------------------------------------------------------------

  defp render(%ComplexType{} = type, namespace, registry) do
    %{attributes: attrs, elements: elems} = flatten(type, registry)

    {embeds, scalar_elems} = Enum.split_with(elems, &embed?(&1, registry))
    scalar_fields = attrs ++ scalar_elems

    """
    defmodule #{namespace}.#{short_name(type.name)} do
      @moduledoc false
      use Ecto.Schema
      import Ecto.Changeset

      @primary_key false
      embedded_schema do
    #{indent(field_lines(scalar_fields) ++ embed_lines(embeds, namespace, registry), 4)}
      end

      def changeset(struct, params) do
        struct
        |> cast(params, #{inspect(Enum.map(scalar_fields, &field_name/1), limit: :infinity)})#{cast_embed_calls(embeds)}
      end
    end
    """
  end

  defp field_lines(fields) do
    Enum.map(fields, fn f -> "field #{inspect(field_name(f))}, #{inspect(ecto_type(f))}" end)
  end

  defp embed_lines(embeds, namespace, registry) do
    Enum.map(embeds, fn %Element{} = e ->
      macro = if e.max == :unbounded or e.max > 1, do: "embeds_many", else: "embeds_one"
      "#{macro} #{inspect(field_name(e))}, #{namespace}.#{short_name(registry[e.type].name)}"
    end)
  end

  defp cast_embed_calls(embeds) do
    embeds
    |> Enum.map(fn e -> "\n    |> cast_embed(#{inspect(field_name(e))})" end)
    |> Enum.join()
  end

  ## extension flattening ----------------------------------------------------

  defp flatten(%ComplexType{base: nil} = type, _registry) do
    %{attributes: type.attributes, elements: type.elements}
  end

  defp flatten(%ComplexType{base: base} = type, registry) do
    parent = flatten(registry[base], registry)

    %{
      attributes: parent.attributes ++ type.attributes,
      elements: parent.elements ++ type.elements
    }
  end

  ## naming + type mapping ---------------------------------------------------

  defp embed?(%Element{type: type}, registry), do: Map.has_key?(registry, type)

  defp field_name(%{name: name}) do
    Map.get_lazy(@rename_overrides, name, fn -> String.to_atom(name) end)
  end

  defp ecto_type(field) do
    case Map.fetch(@type_overrides, field.name) do
      {:ok, type} -> type
      :error -> map_type(field)
    end
  end

  # A repeated simple-typed element becomes an array column.
  defp map_type(%Element{max: max, type: type}) when max == :unbounded or max > 1 do
    {:array, primitive(type)}
  end

  defp map_type(%{type: type}), do: primitive(type)

  defp primitive(type) do
    case type do
      "string" ->
        :string

      "anyURI" ->
        :string

      "token" ->
        :string

      "boolean" ->
        :boolean

      "decimal" ->
        :decimal

      "double" ->
        :float

      "float" ->
        :float

      "dateTime" ->
        :utc_datetime

      "date" ->
        :date

      "time" ->
        :time

      t
      when t in ~w(int integer long short byte nonNegativeInteger positiveInteger unsignedInt) ->
        :integer

      _ ->
        :string
    end
  end

  # Module-friendly name: drop a trailing "Type" and PascalCase what's left, so
  # both PascalCase ("EventType" -> "Event") and camelCase XSD type names
  # ("sportEventStatus" -> "SportEventStatus", "clockType" -> "Clock") work.
  defp short_name(name), do: name |> String.replace_suffix("Type", "") |> Macro.camelize()

  defp indent(lines, n) do
    pad = String.duplicate(" ", n)
    lines |> Enum.map(&(pad <> &1)) |> Enum.join("\n")
  end
end
