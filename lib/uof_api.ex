defmodule UOF.API do
  alias UOF.API.Utils.HTTP

  import SweetXml

  # https://docs.betradar.com/display/BD/UOF+-+Endpoints

  ## descriptions
  def markets(lang \\ "en") do
    endpoint = ["descriptions", lang, "markets.xml"]

    schema = [
      markets: [
        ~x"//market"el,
        id: ~x"./@id"i,
        name: ~x"./@name"s,
        groups: ~x"./@groups"s,
        outcomes: [
          ~x"//outcome"el,
          id: ~x"./@id"i,
          name: ~x"./@name"s
        ],
        specifiers: [
          ~x"//specifier"el,
          name: ~x"./@name"s,
          type: ~x"./@type"s
        ]
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  def match_statuses(lang \\ "en") do
    endpoint = ["descriptions", lang, "match_status.xml"]

    schema = [
      match_statuses: [
        ~x"//match_status"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s,
        sports: [
          ~x"//match_status/sports/sport"el,
          id: ~x"./@id"s
        ]
      ]
    ]

    HTTP.get(endpoint, schema)
  end

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

  def void_reasons do
    endpoint = ["descriptions", "void_reasons.xml"]

    schema = [
      void_reasons: [
        ~x"//void_reason"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

  # TO-DO
  # def market_desctipion(market, variant, lang \\ "en")

  ### probabilities

  def probabilities(fixture_id) do
    endpoint = ["probabilities", fixture_id]

    schema = [
      void_reasons: [
        ~x"//void_reason"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    HTTP.get(endpoint)
    # HTTP.get(endpoint, schema)
  end

  # def probabilities(fixture_id, market_id)
  # def probabilities(fixture_id, market_id, specifiers)

  ### recoveries

  ### sports

  def competitors(id, lang \\ "en") do
    endpoint = ["sports", lang, "competitors", id, "profile.xml"]

    schema = [
      # TO-DO: fill in
    ]

    HTTP.get(endpoint)
    # HTTP.get(endpoint, schema)
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

  # TO-DO: add support for 'after datetime' and 'sport' filters
  def fixture_changes(lang \\ "en") do
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

  # TO-DO: add support for 'after datetime' and 'sport' filters
  def results(lang \\ "en") do
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

  def sports(lang \\ "en") do
    endpoint = ["sports", lang, "sports.xml"]

    schema = [
      sports: [
        ~x"//sport"el,
        id: ~x"./@id"s,
        name: ~x"./@name"s
      ]
    ]

    HTTP.get(endpoint, schema)
  end

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

  def tournament_info(tournament, lang \\ "en") do
    endpoint = ["sports", lang, "tournaments", tournament, "info.xml"]

    schema = [
      # TO-DO: fill in
    ]

    HTTP.get(endpoint)
    # HTTP.get(endpoint, schema)
  end

  def whoami() do
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
end
