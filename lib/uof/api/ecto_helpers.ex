defmodule UOF.API.EctoHelpers do
  @moduledoc false
  import Ecto.Changeset

  @doc """
  Traverse errors is a way to retrieve in a plain format the full list of
  errors for all of the schemas and embedded schemas under the main one.
  """
  def traverse_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end

  def bubble_up(params, level1, level2) do
    values =
      params
      |> Map.get(level1, %{})
      |> Map.get(level2, [])

    case values do
      value when not is_list(value) ->
        Map.put(params, level1, [value])

      _ ->
        Map.put(params, level1, values)
    end
  end

  def split(params, field, separator) do
    values = Map.get(params, field)
    values = String.split(values, separator)
    Map.put(params, field, values)
  end

  def rename(params, old, new, default) do
    {values, params} = Map.pop(params, old, default)
    Map.put(params, new, values)
  end

  def apply(%Ecto.Changeset{valid?: true} = changeset) do
    {:ok, apply_changes(changeset)}
  end

  def apply(%Ecto.Changeset{} = changeset) do
    {:error, traverse_errors(changeset)}
  end
end
