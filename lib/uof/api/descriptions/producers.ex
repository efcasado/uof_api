# https://docs.betradar.com/display/BD/UOF+-+Producers
defmodule UOF.API.Descriptions.Producer do
  @moduledoc """
  Unified Odds Feed handles data from multiple sources, which are called
  odds or message producers.
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all available producers.
  """
  @spec all() :: list(VoidReason.t())
  def all() do
    case UOF.API.get("/descriptions/producers.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("producers")
        |> Map.get("producer")
        |> Enum.map(fn x ->
          {:ok, x} = changeset(x)
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @primary_key false

  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:description, :string)
    field(:api_url, :string)
    field(:active, :boolean)
    field(:scope, {:array, Ecto.Enum}, values: [:live, :prematch, :virtual])
    field(:stateful_recovery_window_in_minutes, :integer)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(prepare(params), [
      :id,
      :name,
      :description,
      :api_url,
      :active,
      :scope,
      :stateful_recovery_window_in_minutes
    ])
    |> case do
      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, apply_changes(changeset)}

      %Ecto.Changeset{} = changeset ->
        {:error, {params, traverse_errors(changeset)}}
    end
  end

  defp prepare(params) do
    params
    |> rename_fields
    |> prepare_scope
  end

  defp prepare_scope(params) do
    scope = String.split(params["scope"], "|")
    Map.put(params, "scope", scope)
  end
end
