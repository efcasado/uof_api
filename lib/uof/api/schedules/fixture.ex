defmodule UOF.API.Schedules.Fixture do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @primary_key false

  embedded_schema do
    field :id, :string
    field :status, :string
    field :next_live_time, :string
    field :scheduled, :string
    field :start_time_tbd, :boolean

    embeds_one :venue, UOF.API.Fixtures.Venue
    embeds_one :season, UOF.API.Tournaments.Season
    embeds_one :round, UOF.API.Tournaments.Round
    embeds_one :tournament, UOF.API.Sports.Tournament
    # embeds_many :competitors, UOF.API.Fixtures.Competitor
  end

  # tournament round
  # attribute(:betradar_id, cast: :integer)
  # attribute(:betradar_name)
  # attribute(:type)
  # # cup
  # attribute(:name)
  # attribute(:cup_round_matches, cast: :integer)
  # attribute(:cup_round_match_number, cast: :integer)
  # attribute(:other_match_id)
  # # group
  # attribute(:number)
  # attribute(:group)
  # attribute(:group_id)
  # attribute(:group_long_name)
  # # qualification
  # # ???
  # attribute(:phase)

  def changeset(model \\ %__MODULE__{}, params) do
    params = rename(params, "tournament_round", "round", nil)

    model
    |> cast(params, [:id, :status, :next_live_time, :scheduled, :start_time_tbd])
    |> cast_embed(:venue)
    |> cast_embed(:season)
    |> cast_embed(:round)
    |> cast_embed(:tournament)

    # |> cast_embed(:competitors)
  end
end
