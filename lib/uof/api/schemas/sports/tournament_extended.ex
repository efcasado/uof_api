defmodule UOF.API.Schemas.Sports.TournamentExtended do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:exhibition_games, :boolean)
    field(:scheduled, :utc_datetime)
    field(:scheduled_end, :utc_datetime)
    embeds_one(:tournament_length, UOF.API.Schemas.Sports.TournamentLength)
    embeds_one(:sport, UOF.API.Schemas.Sports.Sport)
    embeds_one(:category, UOF.API.Schemas.Sports.Category)
    embeds_one(:current_season, UOF.API.Schemas.Sports.CurrentSeason)
    embeds_one(:season_coverage_info, UOF.API.Schemas.Sports.SeasonCoverageInfo)
    embeds_one(:competitors, UOF.API.Schemas.Sports.Competitors)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name, :exhibition_games, :scheduled, :scheduled_end])
    |> cast_embed(:tournament_length)
    |> cast_embed(:sport)
    |> cast_embed(:category)
    |> cast_embed(:current_season)
    |> cast_embed(:season_coverage_info)
    |> cast_embed(:competitors)
  end
end
