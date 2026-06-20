defmodule UOF.API.Schemas.Sports.SportEventStatus do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:status, :string)
    field(:match_status, :string)
    field(:winner_id, :string)
    field(:winning_reason, :string)
    field(:decided_by_fed, :boolean)
    field(:period, :integer)
    field(:home_score, :string)
    field(:away_score, :string)
    field(:aggregate_home_score, :string)
    field(:aggregate_away_score, :string)
    field(:aggregate_winner_id, :string)
    field(:status_code, :integer)
    field(:match_status_code, :integer)
    embeds_many(:clock, UOF.API.Schemas.Sports.Clock)
    embeds_one(:period_scores, UOF.API.Schemas.Sports.PeriodScores)
    embeds_one(:results, UOF.API.Schemas.Sports.ResultScores)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :status,
      :match_status,
      :winner_id,
      :winning_reason,
      :decided_by_fed,
      :period,
      :home_score,
      :away_score,
      :aggregate_home_score,
      :aggregate_away_score,
      :aggregate_winner_id,
      :status_code,
      :match_status_code
    ])
    |> cast_embed(:clock)
    |> cast_embed(:period_scores)
    |> cast_embed(:results)
  end
end
