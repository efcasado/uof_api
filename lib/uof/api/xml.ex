defmodule UOF.API.XML do
  @moduledoc false
  # Generic XML -> Ecto embedded schema decoder.
  #
  # Parses an XML response with saxy and, driven purely by the target schema's
  # Ecto reflection, builds a (possibly deeply nested) params map that is cast
  # through the schema's changeset. Because the generated schemas mirror the XSD
  # nesting, every XML element/attribute name lines up with a schema field name,
  # so one recursive walk handles all of them.

  @doc """
  Decode an XML string into `module`'s struct, returning `{:ok, struct}` or
  `{:error, Ecto.Changeset.t()}`.
  """
  def decode(xml, module) when is_binary(xml) do
    {:ok, root} = Saxy.SimpleForm.parse_string(xml)

    module
    |> struct()
    |> module.changeset(to_params(root, module))
    |> Ecto.Changeset.apply_action(:insert)
  end

  # Build a params map for `module` from a `{tag, attributes, children}` node.
  defp to_params({_tag, attributes, children}, module) do
    child_elements = Enum.filter(children, &is_tuple/1)
    embeds = module.__schema__(:embeds)
    scalar_fields = module.__schema__(:fields) -- embeds

    attributes
    |> Map.new(fn {name, value} -> {local(name), value} end)
    |> put_scalar_elements(scalar_fields, child_elements)
    |> put_embeds(embeds, child_elements, module)
  end

  # Scalar fields may also arrive as text-bearing child elements (e.g.
  # <message>...</message>); attributes already present win.
  defp put_scalar_elements(params, scalar_fields, child_elements) do
    Enum.reduce(scalar_fields, params, fn field, acc ->
      name = Atom.to_string(field)

      cond do
        Map.has_key?(acc, name) -> acc
        element = find(child_elements, name) -> Map.put(acc, name, text(element))
        true -> acc
      end
    end)
  end

  defp put_embeds(params, embeds, child_elements, module) do
    Enum.reduce(embeds, params, fn embed, acc ->
      %Ecto.Embedded{related: related, cardinality: cardinality} =
        module.__schema__(:embed, embed)

      name = Atom.to_string(embed)
      matches = filter(child_elements, name)

      value =
        case cardinality do
          :one -> matches |> List.first() |> maybe_to_params(related)
          :many -> Enum.map(matches, &to_params(&1, related))
        end

      if value in [nil, []], do: acc, else: Map.put(acc, name, value)
    end)
  end

  defp maybe_to_params(nil, _module), do: nil
  defp maybe_to_params(element, module), do: to_params(element, module)

  defp find(elements, name), do: Enum.find(elements, &named?(&1, name))
  defp filter(elements, name), do: Enum.filter(elements, &named?(&1, name))
  defp named?({tag, _a, _c}, name), do: local(tag) == name

  defp text({_tag, _attrs, children}) do
    children |> Enum.filter(&is_binary/1) |> Enum.join() |> String.trim()
  end

  # Drop any namespace prefix ("ns:market" -> "market").
  defp local(name) do
    case String.split(name, ":", parts: 2) do
      [_prefix, local] -> local
      [local] -> local
    end
  end
end
