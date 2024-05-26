defmodule UOF.API.Tournaments.TournamentInfo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @primary_key false

  # Example. sr:tournament:1211
  embedded_schema do
    # nested schema instead?
    embeds_one :tournament, UOF.API.Sports.Tournament
    embeds_one :season, UOF.API.Tournaments.Season
    embeds_one :round, UOF.API.Tournaments.Round
    embeds_one :season_coverage_info, UOF.API.Tournaments.SeasonCoverageInfo
    embeds_one :coverage_info, UOF.API.Tournaments.CoverageInfo
    embeds_many :groups, UOF.API.Tournaments.Group
  end

  def changeset(model \\ %__MODULE__{}, params) do
    params = params["tournament_info"]
    params = bubble_up(params, "groups", "group")

    model
    |> cast(params, [])
    |> cast_embed(:tournament)
    |> cast_embed(:season)
    |> cast_embed(:season_coverage_info)
    |> cast_embed(:coverage_info)
    |> cast_embed(:round)
    |> cast_embed(:groups)
  end
end
