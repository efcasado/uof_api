defmodule UOF.API.Fixtures.Fixture do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  # attribute(:start_time_confirmed, cast: :boolean)
  # attribute(:start_time)
  # attribute(:liveodds)
  # attribute(:status)
  # attribute(:next_live_time)
  # attribute(:id)
  # attribute(:scheduled)
  # attribute(:start_time_tbd, cast: :boolean)
  # elements(:competitor, as: :competitors, into: %Competitor{})
  # elements(:tv_channel, as: :tv_channels, into: %TVChannel{})
  # elements(:info, as: :extra_info, into: %ExtraInfo{})
  # elements(:reference_id, as: :references, into: %Reference{})
  # element(:tournament_round, into: %TournamentRound{})
  # element(:tournament, into: %Tournament{})
  # element(:season, into: %Season{})
  # element(:venue, into: %Venue{})
  # element(:coverage_info, into: %CoverageInfo{})
  # element(:product_info, into: %ProductInfo{})

  @primary_key false

  embedded_schema do
    field :start_time_confirmed, :boolean
    field :start_time
    field :liveodds
    field :status
    field :next_live_time
    field :id
    field :scheduled
    field :start_time_tbd, :boolean
    # field :tv_channels, {:array, :string}
    embeds_one :season, UOF.API.Tournaments.Season
    embeds_one :tournament, UOF.API.Sports.Tournament
    embeds_one :tournament_round, UOF.API.Tournaments.TournamentRound
    embeds_many :competitors, UOF.API.Competitors.Competitor
    embeds_many :extra_info, UOF.API.Fixtures.ExtraInfo
    embeds_many :reference_ids, UOF.API.Fixtures.ReferenceId
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :start_time_confirmed,
      :start_time,
      :liveodds,
      :status,
      :next_live_time,
      :id,
      :scheduled,
      :start_time_tbd
      # :tv_channels
    ])
    |> cast_embed(:season)
    |> cast_embed(:tournament)
    |> cast_embed(:tournament_round)
    |> cast_embed(:competitors)
    |> cast_embed(:extra_info)
    |> cast_embed(:reference_ids)
  end
end
