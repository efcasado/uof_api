defmodule UOF.API.Schemas.Sports.TournamentInfoEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:tournament, UOF.API.Schemas.Sports.TournamentExtended)
    embeds_one(:season, UOF.API.Schemas.Sports.SeasonExtended)
    embeds_one(:round, UOF.API.Schemas.Sports.MatchRound)
    embeds_one(:season_coverage_info, UOF.API.Schemas.Sports.SeasonCoverageInfo)
    embeds_one(:coverage_info, UOF.API.Schemas.Sports.TournamentLiveCoverageInfo)
    embeds_one(:groups, UOF.API.Schemas.Sports.TournamentGroups)
    embeds_one(:competitors, UOF.API.Schemas.Sports.Competitors)
    embeds_one(:children, UOF.API.Schemas.Sports.Children)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:tournament)
    |> cast_embed(:season)
    |> cast_embed(:round)
    |> cast_embed(:season_coverage_info)
    |> cast_embed(:coverage_info)
    |> cast_embed(:groups)
    |> cast_embed(:competitors)
    |> cast_embed(:children)
  end
end
