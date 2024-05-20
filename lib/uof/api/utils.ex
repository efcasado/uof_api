# https://github.com/homanchou/elixir-xml-to-map
# https://github.com/qcam/saxy/issues/103
defmodule UOF.API.Utils do
  @moduledoc false

  def xml_to_map([{tag, attributes, content}]) do
    xml_to_map({tag, attributes, content})
  end

  def xml_to_map([value]) do
    to_string(value) |> String.trim()
  end

  def xml_to_map({tag, [], content}) do
    xml_to_mapd_content = xml_to_map(content)
    %{to_string(tag) => xml_to_mapd_content}
  end

  def xml_to_map({tag, attributes, content}) do
    attributes_map = Map.new(attributes)

    xml_to_mapd_content = xml_to_map(content)
    joined_content = Map.merge(xml_to_mapd_content, attributes_map)

    %{to_string(tag) => joined_content}
  end

  def xml_to_map(list) when is_list(list) do
    parsed_list =
      list
      |> Enum.reject(fn
        str when is_binary(str) -> String.trim(str) == ""
        _ -> false
      end)
      |> Enum.map(&{to_string(elem(&1, 0)), xml_to_map(&1)})

    Enum.reduce(parsed_list, %{}, fn {k, v}, acc ->
      case Map.get(acc, k) do
        nil ->
          for({key, value} <- v, into: %{}, do: {key, value})
          |> Map.merge(acc)

        [h | t] ->
          Map.put(acc, k, [h | t] ++ [v[k]])

        prev ->
          Map.put(acc, k, [prev] ++ [v[k]])
      end
    end)
  end
end
