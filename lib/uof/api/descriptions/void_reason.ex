# https://docs.betradar.com/display/BD/UOF+API+-+Void+Reasons
defmodule UOF.API.Descriptions.VoidReason do
  @moduledoc """
  `BetSettlement` and `BetCancel` messages may be annotated with a `VoidReason`
  for a particular market. This happens when at least on of the aoutcomes.
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all sport-specific match statuses.

  By default, match status descriptions are provided in English. These can
  be retrieved in another language by specifying a valid language as `lang`.
  """
  @spec all() :: list(VoidReason.t())
  def all() do
    case UOF.API.get("/descriptions/void_reasons.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("void_reasons_descriptions")
        |> Map.get("void_reason")
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

    field(:description, Ecto.Enum,
      values: [
        :OTHER,
        # deprecated as per Betradar's official documentation
        :NO_GOALSCORER,
        # deprecated as per Betradar's official documentation
        :CORRECT_SCORE_MISSING,
        :RESULT_UNVERIFIABLE,
        :FORMAT_CHANGE,
        :CANCELLED_EVENT,
        # deprecated as per Betradar's official documentation
        :MISSING_GOALSCORER,
        :MATCH_ENDED_IN_WALKOVER,
        :DEAD_HEAT,
        :RETIRED_OR_DEFAULTED,
        :EVENT_ABANDONED,
        :EVENT_POSTPONED,
        :INCORRECT_ODDS,
        :INCORRECT_STATISTICS,
        :NO_RESULT_ASSIGNABLE,
        :CLIENT_SIDE_SETTLEMENT_NEEDED,
        :STARTING_PITCHER_CHANGED
      ]
    )
  end

  def changeset(model \\ %__MODULE__{}, params) do
    params = sanitize(params)

    model
    |> cast(params, [:id, :description])
    |> apply
  end
end
