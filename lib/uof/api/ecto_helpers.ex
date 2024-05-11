defmodule UOF.API.EctoHelpers do
  @moduledoc """
  Ecto Helpers is a module that is ensuring we have the common functions in
  use for most of the schemas or modules that uses Ecto.
  """
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

  @doc """
  Remove leading '@' from field names in the `params` map.
  """
  def rename_fields(params) do
    params
    |> Enum.map(fn
      {<<"@", key::binary>>, value} -> {key, value}
      other -> other
    end)
    |> Map.new()
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
