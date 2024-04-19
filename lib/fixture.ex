defmodule UOF.API.Fixture do
  @moduledoc """
  """
  alias UOF.API.Competitor
  alias UOF.API.Season
  alias UOF.API.Tournament
  alias UOF.API.TournamentRound
  alias UOF.API.Venue
  import SweetXml

  defstruct id: "",
    scheduled: "",
    start_time_tbd: "",
    start_time_confirmed: "",
    liveodds: "",
    next_live_time: "",
    tournament_round: %UOF.API.TournamentRound{},
    tournament: %UOF.API.Tournament{},
    tv_channels: [],
    extra_info: [],
    coverage_info: "",
    references: []

  @type t :: %__MODULE__{
    id: String.t,
    scheduled: String.t,
    start_time_tbd: String.t,
    start_time_confirmed: String.t,
    liveodds: String.t,
    next_live_time: String.t,
    tournament_round: TournamentRound.t,
    tournament: Tournament.t,
    tv_channels: list(TVChannel.t),
    extra_info: list(Info.t),
    coverage_info: CoverageInfo.t,
    references: list(Reference.t)
  }

  def schema do
    [
      start_time_confirmed: ~x"//fixture/@start_time_confirmed"s,
      start_time: ~x"//fixture/@start_time"s,
      liveodds: ~x"//fixture/@liveodds"s,
      status: ~x"//fixture/@status"s,
      next_live_time: ~x"//fixture/@next_live_time"s,
      id: ~x"//fixture/@id"s,
      scheduled: ~x"//fixture/@scheduled"s,
      start_time_tbd: ~x"//fixture/@start_time_tbd"s,
      tournament: [~x"//fixture/tournament" | Tournament.schema],
      tournament_round: [~x"//fixture/tournament_round" | TournamentRound.schema],
      season: [~x"//fixture/season"o | Season.schema],
      competitors: [~x"//fixture/competitors/competitor"el | Competitor.schema],
      venue: [~x"//fixture/venue"o | Venue.schema],
      # https://docs.betradar.com/display/BD/UOF+-+Fixture+end+point
      tv_channels: [
        ~x"//fixture/tv_channels/tv_channel"el,
        name: ~x"./@name"s
      ],
      # https://docs.betradar.com/display/BD/UOF+-+Fixture+end+point
      extra_info: [
        ~x"//fixture/extra_info/info"el,
        key: ~x"./@key"s,
        value: ~x"./@value"s
      ],
      # TO-DO: confirm implementation; missing documentation
      coverage_info: [~x"//fixture/coverage_info"o | CoverageInfo.schema],
      # TO-DO: product_info
      references: [~x"//fixture/reference_ids/reference_id"el| Reference.schema]
    ]
  end
end
