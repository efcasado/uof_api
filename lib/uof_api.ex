defmodule UOF.API do
  # https://docs.betradar.com/display/BD/UOF+-+Endpoints
  alias UOF.API.Market
  alias UOF.API.MatchStatus
  alias UOF.API.VoidReason
  alias UOF.API.Utils.HTTP
  import SweetXml

  @group id: ~x"./@id"s,
         name: ~x"./@name"s,
         competitors: [~x"./competitor"el | @competitor]

  ## Betting Descriptions
  ## =========================================================================

  @doc """
  Describe all currently available markets.

  ## Example

      iex> markets = UOF.API.markets("en")
      ...> [m| _] = Enum.sort(markets, fn(%{id: id1}, %{id: id2}) -> id1 < id2 end)
      ...> %{id: 1, name: "1x2"} = m
  """
  def markets(lang \\ "en") do
    # TO-DO: Optional mappings
    endpoint = ["descriptions", lang, "markets.xml"]

    schema = [markets: [~x"//market"el| Market.schema]]

    %{markets: markets} = HTTP.get(endpoint, schema)
    markets
  end

  @doc """
  Describe all sport-specific match status codes used during live matches in
  `odds_change` messages.

  ## Example

      iex> statuses = UOF.API.match_statuses("en")
      ...> 185 = Enum.count(statuses)
      ...> %{id: 0, description: "Not started"} = hd(statuses)
      ...> %{id: 548, description: "Break top EI bottom 7"} = hd(Enum.reverse(statuses))
  """
  def match_statuses(lang \\ "en") do
    endpoint = ["descriptions", lang, "match_status.xml"]

    schema = [match_statuses: [~x"//match_status"el| MatchStatus.schema]]

    %{match_statuses: statuses} = HTTP.get(endpoint, schema)
    statuses
  end

  @doc """
  Describe all bet stop reasons.

  ## Example

      iex> %{betstop_reasons: reasons} = UOF.API.betstop_reasons
      ...> 90 = Enum.count(reasons)
      ...> %{id: 0, description: "UNKNOWN"} = hd(reasons)
      ...> %{id: 89, description: "POSSIBLE_VIDEO_ASSISTANT_REFEREE_AWAY"} = hd(Enum.reverse(reasons))
  """
  def betstop_reasons do
    endpoint = ["descriptions", "betstop_reasons.xml"]

    schema = [
      betstop_reasons: [
        ~x"//betstop_reason"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  @doc """
  Describes all betting statuses used in `odds_change` messages.

  ## Example

      iex> %{betting_statuses: statuses} = UOF.API.betting_statuses
      ...> 7 = Enum.count(statuses)
      ...> %{id: 0, description: "UNKNOWN"} = hd(statuses)
      ...> %{id: 6, description: "INGAME_PENALTY"} = hd(Enum.reverse(statuses))
  """
  def betting_statuses do
    endpoint = ["descriptions", "betting_status.xml"]

    schema = [
      betting_statuses: [
        ~x"//betting_status"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  @doc """
  Describe all currently avbailable producers and their ids.

  ## Example

      iex> %{producers: producers} = UOF.API.producers
      ...> 15 = Enum.count(producers)
      ...> %{id: 1, name: "LO"} = hd(producers)
      ...> %{id: 17, name: "VCI"} = hd(Enum.reverse(producers))
  """
  def producers do
    endpoint = ["descriptions", "producers.xml"]

    schema = [
      producers: [
        ~x"//producer"el,
        id: ~x"./@id"i,
        name: ~x"./@name"s,
        description: ~x"./@description"s,
        api_url: ~x"./@api_url"s,
        active: ~x"./@active"s,
        scope: ~x"./@scope"s,
        stateful_recovery_window_in_minutes: ~x"./@stateful_recovery_window_in_minutes"i
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  @doc """
  Describe all possible void reasons used in `bet_settlement` messages.

  ## Example

      iex> %{void_reasons: reasons} = UOF.API.void_reasons
      ...> 17 = Enum.count(reasons)
      ...> %{id: 0, description: "OTHER"} = hd(reasons)
      ...> %{id: 16, description: "STARTING_PITCHER_CHANGED"} = hd(Enum.reverse(reasons))
  """
  def void_reasons do
    endpoint = ["descriptions", "void_reasons.xml"]

    schema = [
      void_reasons: [ ~x"//void_reason"el| VoidReason.schema] ]

    HTTP.get(endpoint, schema)
  end

  # TO-DO
  # def market_desctipion(market, variant, lang \\ "en")

  ## Static Sport Event Information
  ## =========================================================================

  @doc """
  Get the details of the given fixture.

  ## Example

      iex> UOF.API.fixture("sr:match:49430515")
  """
  def fixture(fixture, lang \\ "en") do
    # TO-DO: handle codds fixture
    #     <fixtures_fixture generated_at="2024-04-19T06:58:23.170+00:00" xsi:schemaLocation="http://schemas.sportradar.com/sportsapi/v1/unified http://schemas.sportradar.com/bsa-staging/unified/v1/xml/endpoints/unified/fixtures_fixture.xsd" xmlns="http://schemas.sportradar.com/sportsapi/v1/unified" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    #     <fixture id="codds:competition_group:77739" type="child" stage_type="competition_group" scheduled="2024-04-18T14:50:00+00:00">
    #         <parent id="sr:stage:1189639" name="Round 1" type="parent" stage_type="round"/>
    #         <tournament id="sr:stage:1117573" name="PGA Tour 2024" scheduled="2024-01-04T10:00:00+00:00" scheduled_end="2024-12-16T05:00:00+00:00">
    #             <sport id="sr:sport:9" name="Golf"/>
    #             <category id="sr:category:28" name="Men"/>
    #         </tournament>
    #         <competitors>
    #             <competitor id="sr:competitor:44267" name="FLEETWOOD, TOMMY" abbreviation="FLE"/>
    #             <competitor id="sr:competitor:127560" name="HOMA, MAX" abbreviation="HOM"/>
    #         </competitors>
    #         <extra_info>
    #             <info key="course" value="sr:venue:20693"/>
    #             <info key="play_type" value="stroke_play"/>
    #             <info key="play_format" value="singles"/>
    #         </extra_info>
    #     </fixture>
    # </fixtures_fixture>
    endpoint = ["sports", lang, "sport_events", fixture, "fixture.xml"]

    schema = [
      start_time_confirmed: ~x"//fixture/@start_time_confirmed"s,
      start_time: ~x"//fixture/@start_time"s,
      liveodds: ~x"//fixture/@liveodds"s,
      status: ~x"//fixture/@status"s,
      next_live_time: ~x"//fixture/@next_live_time"s,
      id: ~x"//fixture/@id"s,
      scheduled: ~x"//fixture/@scheduled"s,
      start_time_tbd: ~x"//fixture/@start_time_tbd"s,
      tournament: [~x"//fixture/tournament" | @tournament],
      tournament_round: [~x"//fixture/tournament_round" | @tournament_round],
      season: [~x"//fixture/season"o | @season],
      competitors: [~x"//fixture/competitors/competitor"el | @competitor],
      venue: [~x"//fixture/venue"o | @venue],
      tv_channels: [
        # https://docs.betradar.com/display/BD/UOF+-+Fixture+end+point
        # TO-DO: confirm implementation
        ~x"//fixture/tv_channels/tv_channel"el,
        name: ~x"./@name"s
      ],
      extra_info: [
        # https://docs.betradar.com/display/BD/UOF+-+Fixture+end+point
        ~x"//fixture/extra_info/info"el,
        key: ~x"./@key"s,
        value: ~x"./@value"s
      ],
      # TO-DO: confirm implementation; missing documentation
      coverage_info: [~x"//fixture/coverage_info"o | @coverage_info],
      # TO-DO: product_info
      references: [
        # TO-DO: confirm implementation
        ~x"//fixture/reference_ids/reference_id"el,
        name: ~x"./@name"s,
        value: ~x"./@value"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  # date = "live | <date> | pre (start, limit)"
  def schedules(date, lang \\ "en") do
    endpoint = ["sports", lang, "schedules", date, "schedule.xml"]

    # TO-DO: complete schema
    schema = [
      sport_events: [
        ~x"//sport_event"el,
        liveodds: ~x"./@liveodds"s,
        status: ~x"./@status"s,
        next_live_time: ~x"./@next_live_time"s,
        id: ~x"./@id"s,
        scheduled: ~x"./@scheduled",
        start_time_tbd: ~x"./@start_time_tbd"
      ]
    ]

    # HTTP.get(endpoint)
    HTTP.get(endpoint, schema)
  end

  def fixture_changes(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "fixtures", "changes.xml"]

    schema = [
      fixture_changes: [
        ~x"//fixture_change"el,
        sport_event_id: ~x"./@sport_event_id"s,
        update_time: ~x"./@update_time"s
      ]
    ]

    # HTTP.get(endpoint)
    HTTP.get(endpoint, schema)
  end

  @doc """
  Get a list of all fixtures with result changes.

  ## Example

      iex> %{result_changes: results} = UOF.API.results
      ...> [%{sport_event_id: fixture, update_time: ts}| _] = results
  """
  def results(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "results", "changes.xml"]

    schema = [
      result_changes: [
        ~x"//result_change"el,
        sport_event_id: ~x"./@sport_event_id"s,
        update_time: ~x"./@update_time"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  ## Sport Event Information
  ## =========================================================================

  @doc """
  Get information and results for the given fixture.
  """
  def summary(fixture, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Summary+end+point
    endpoint = ["sports", lang, "sport_events", fixture, "summary.xml"]

    schema = [
      tournament_round: [~x"//tournament_round" | @tournament_round],
      season: [~x"//season"o | @season],
      tournament: [~x"//tournament" | @tournament],
      competitors: [~x"//competitors/competitor"el | @competitor],
      # TO-DO: implement event_conditions
      # event_conditions: [
      # https://docs.betradar.com/display/BD/Sport_event_condition
      # ],
      event_status: [
        # https://docs.betradar.com/display/BD/Sport+event+status
        ~x"//sport_event_status",
        status: ~x"./@status"s,
        status_code: ~x"./@status_code"i,
        match_status_code: ~x"./@match_status_code"i,
        home_score: ~x"./@home_score"oi,
        away_score: ~x"./@away_score"oi,
        winner_id: ~x"./@winner_id"s
      ],
      coverage_info: [~x"//coverage_info" | @coverage_info]
    ]

    HTTP.get(endpoint, schema)
  end

  @doc """
  List all the available sports.

  ## Example

      iex> UOF.API.sports
  """
  def sports(lang \\ "en") do
    endpoint = ["sports", lang, "sports.xml"]

    schema = [sports: [~x"//sport"el | @sport]]

    %{sports: sports} = HTTP.get(endpoint, schema)
    sports
  end

  @doc """
  List all the available categories for the given sport.

  ## Example

      iex> UOF.API.categories("sr:sport:1")
  """
  def categories(sport, lang \\ "en") do
    endpoint = ["sports", lang, "sports", sport, "categories.xml"]

    schema = [
      categories: [
        ~x"//category"el,
        id: ~x"./@id"s,
        name: ~x"./@name"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  def tournaments(lang \\ "en") do
    endpoint = ["sports", lang, "tournaments.xml"]

    # TO-DO: avoid lists in sports, categories, current_season and season_coverage_info
    schema = [
      tournaments: [
        ~x"//tournament"el,
        id: ~x"./@id"s,
        name: ~x"./@description"s,
        sport: [
          ~x"//tournament/sport"el,
          id: ~x"./@id"s,
          name: ~x"./@name"s
        ],
        category: [
          ~x"//tournament/category"el,
          id: ~x"./@id"s,
          name: ~x"./@name"s
        ],
        current_season: [
          ~x"//tournament/current_season"el,
          id: ~x"./@id"s,
          name: ~x"./@name"s,
          start_date: ~x"./@start_date"s,
          end_date: ~x"./@end_date"s,
          year: ~x"./@end_date"s
        ],
        season_coverage_info: [
          ~x"//tournament/season_coverage_info"el,
          season_id: ~x"./@season_id"s,
          scheduled: ~x"./@scheduled"i,
          played: ~x"./@played"s,
          max_coverage_level: ~x"./@max_coverage_level"s,
          max_covered: ~x"./@max_covered"i,
          min_coverage_level: ~x"./@min_coverage_level"s
        ]
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  @doc """
  Get details about the given tournament.

  ## Example

      iex> %{tournaments: tournaments} = UOF.API.tournaments
      ...> %{id: id} = hd(tournaments)
      ...> UOF.API.tournament(id)
  """
  def tournament(tournament, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
    endpoint = ["sports", lang, "tournaments", tournament, "info.xml"]

    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    schema = [
      tournament: [~x"//tournament" | @tournament],
      season: [~x"//season"o | @season],
      season_coverage: [~x"//season_coverage_info"o | @season_coverage],
      groups: [~x"//groups/group"el | @group],
      coverage_info: [~x"//coverage_info" | @coverage_info]
    ]

    HTTP.get(endpoint, schema)
  end

  ## Entity Description
  ## =========================================================================
  @doc """
  Get the details of the given player.

  ## Example

      iex> UOF.API.player("sr:player:852078")
      ...> # %{
      ...> #   player: %{
      ...> #     id: "sr:player:852078",
      ...> #     name: "Dekker, Sam",
      ...> #     type: "F",
      ...> #     gender: "male",
      ...> #     country_code: "USA",
      ...> #     date_of_birth: "1994-05-06",
      ...> #     nationality: "Usa",
      ...> #     height: 203,
      ...> #     weight: 99,
      ...> #     full_name: "Sam Dekker"
      ...> #   }
      ...> # }
  """
  def player(player, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Player+profile
    endpoint = ["sports", lang, "players", player, "profile.xml"]

    schema = [player: [~x"//player" | @player]]

    HTTP.get(endpoint, schema)
  end

  @doc """
  Get the details of the given competitor.

  ## Example

      iex> UOF.API.competitor("sr:competitor:38007")
  """
  def competitor(competitor, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Competitors+profile
    endpoint = ["sports", lang, "competitors", competitor, "profile.xml"]

    schema = [
      competitor: [~x"//competitor" | @competitor],
      sport: [~x"//sport" | @sport],
      category: [~x"//category" | @category],
      venue: [~x"//venue" | @venue],
      jerseys: [~x"//jerseys/jersey"el | @jersey],
      players: [~x"//players/player"el | @player]
    ]

    HTTP.get(endpoint, schema)
  end

  @doc """
  Get the details of the given venue.

  ## Example

      iex> UOF.API.venue("sr:venue:6030")
      ...> # %{
      ...> #   venue: %{
      ...> #     id: "sr:venue:6030",
      ...> #     name: "Scotiabank Arena",
      ...> #     country_code: "CAN",
      ...> #     capacity: 19800,
      ...> #     city_name: "Toronto",
      ...> #     country_name: "Canada",
      ...> #     map_coordinates: "43.643333,-79.379167"
      ...> #   },
      ...> #   home_teams: [
      ...> #     %{
      ...> #       id: "sr:competitor:3433",
      ...> #       name: "Toronto Raptors",
      ...> #       state: "",
      ...> #       references: [],
      ...> #       country: "USA",
      ...> #       abbreviation: "TOR",
      ...> #       qualifier: "",
      ...> #       virtual: "",
      ...> #       gender: "male"
      ...> #     },
      ...> #     %{
      ...> #       id: "sr:competitor:3693",
      ...> #       name: "Toronto Maple Leafs",
      ...> #       state: "",
      ...> #       references: [],
      ...> #       country: "USA",
      ...> #       abbreviation: "TOR",
      ...> #       qualifier: "",
      ...> #       virtual: "",
      ...> #       gender: "male"
      ...> #     }
      ...> #   ]
      ...> # }
  """
  def venue(venue, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Venues
    endpoint = ["sports", lang, "venues", venue, "profile.xml"]

    schema = [
      venue: [~x"//venue" | @venue],
      home_teams: [~x"//home_teams/competitor"el | @competitor]
    ]

    HTTP.get(endpoint, schema)
  end

  ## User Information
  ## =========================================================================

  @doc """
  Get information about the token being used.
  """
  def whoami do
    endpoint = ["users", "whoami.xml"]

    schema = [
      # bookmaker_details: [
      expirete_at: ~x"//bookmaker_details/@expire_at"s,
      bookmaker_id: ~x"//bookmaker_details/@bookmaker_id"i,
      virtual_host: ~x"//bookmaker_details/@virtual_host"s
      # ]
    ]

    HTTP.get(endpoint, schema)
  end

  ## Probability API
  ## =========================================================================
  def probabilities(fixture) do
    endpoint = ["probabilities", fixture]
    # TO-DO: parse response
    HTTP.get(endpoint)
  end

  def probabilities(fixture, market) do
    endpoint = ["probabilities", fixture, market]
    # TO-DO: parse response
    HTTP.get(endpoint)
  end

  def probabilities(fixture, market, specifiers) do
    endpoint = ["probabilities", fixture, market, specifiers]
    # TO-DO: parse response
    HTTP.get(endpoint)
  end

  ## Custom Bet API
  ## =========================================================================
  # TO-DO

  ## Recovery API
  ## =========================================================================
  # TO-DO
end
