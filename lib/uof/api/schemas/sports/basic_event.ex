defmodule UOF.API.Schemas.Sports.BasicEvent do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:type, :string)
    field(:time, :utc_datetime)
    field(:period_name, :string)
    field(:match_time, :integer)
    field(:match_clock, :string)
    field(:team, :string)
    field(:x, :integer)
    field(:y, :integer)
    field(:home_score, :string)
    field(:away_score, :string)
    field(:period, :string)
    field(:stoppage_time, :string)
    field(:value, :string)
    field(:points, :string)
    field(:match_status_code, :integer)
    embeds_one(:goal_scorer, UOF.API.Schemas.Sports.EventPlayer)
    embeds_one(:player, UOF.API.Schemas.Sports.EventPlayer)
    embeds_many(:assist, UOF.API.Schemas.Sports.EventPlayerAssist)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :type,
      :time,
      :period_name,
      :match_time,
      :match_clock,
      :team,
      :x,
      :y,
      :home_score,
      :away_score,
      :period,
      :stoppage_time,
      :value,
      :points,
      :match_status_code
    ])
    |> cast_embed(:goal_scorer)
    |> cast_embed(:player)
    |> cast_embed(:assist)
  end
end
