defmodule UOF.API.Descriptions.BettingStatus do
  @moduledoc """
  When betting markets get opened after a `BetStop` but it is still early after
  the markets got closed due to a `BetStop`, `OddsChange` messages may be
  annotated with a `BettingStatus` explaining the reason of a preceeding `BetStop`
  message.

  Risk sensitive users may decide to keep markets closed until `BettingStatus` is
  no longer present in `OddsChange` messages.
  """
  use Ecto.Schema

  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @primary_key false

  embedded_schema do
    field(:id, :integer)

    field(:description, Ecto.Enum,
      values: [
        :UNKNOWN,
        :GOAL,
        :DANGEROUS_FREE_KICK,
        :DANGEROUS_GOAL_POSITION,
        :POSSIBLE_BOUNDARY,
        :POSSIBLE_CHECKOUT,
        :INGAME_PENALTY
      ]
    )
  end

  def cast(params) do
    %__MODULE__{}
    |> cast(attrs(params), [:id, :description])
    |> case do
      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, apply_changes(changeset)}

      %Ecto.Changeset{} = changeset ->
        {:error, {params, traverse_errors(changeset)}}
    end
  end

  defp attrs(params) do
    params
    |> Enum.map(fn
      {"@id", val} -> {:id, val}
      {"@description", val} -> {:description, val}
      x -> x
    end)
    |> Map.new()
  end

  @doc """
  List all supported betting statuses.
  """
  @spec all() :: list(BettingStatus.t())
  def all() do
    case UOF.API.get("/descriptions/betting_status.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("betting_status_descriptions")
        |> Map.get("betting_status")
        |> Enum.map(fn x ->
          {:ok, x} = cast(x)
          x
        end)

      {:error, _} = error ->
        error
    end
  end
end
