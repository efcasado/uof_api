defmodule UOF.API do
  import SweetXml

  # https://docs.betradar.com/display/BD/UOF+-+Endpoints

  ## descriptions
  def markets(lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "descriptions", lang, "markets.xml"], "/")

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

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def match_statuses(lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "descriptions", lang, "match_status.xml"], "/")

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

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def betstop_reasons do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "descriptions", "betstop_reasons.xml"], "/")

    schema = [
      betstop_reasons: [
        ~x"//betstop_reason"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def betting_statuses do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "descriptions", "betting_status.xml"], "/")

    schema = [
      betting_statuses: [
        ~x"//betting_status"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def producers do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "descriptions", "producers.xml"], "/")

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

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def void_reasons do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "descriptions", "void_reasons.xml"], "/")

    schema = [
      void_reasons: [
        ~x"//void_reason"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  ### probabilities

  def probabilities(fixture_id) do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "probabilities", fixture_id], "/")

    schema = [
      void_reasons: [
        ~x"//void_reason"el,
        id: ~x"./@id"i,
        description: ~x"./@description"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body

    # |> SweetXml.xmap(schema)
  end

  # def probabilities(fixture_id, market_id)
  # def probabilities(fixture_id, market_id, specifiers)

  ### recoveries

  ### sports

  def competitors(id, lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "sports", lang, "competitors", id, "profile.xml"], "/")

    schema = [
      # TO-DO: fill in
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body

    # |> SweetXml.xmap(schema)
  end

  # TO-DO: add support for 'after datetime' and 'sport' filters
  def fixture_changes(lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "sports", lang, "fixtures", "changes.xml"], "/")

    schema = [
      fixture_changes: [
        ~x"//fixture_change"el,
        sport_event_id: ~x"./@sport_event_id"s,
        update_time: ~x"./@update_time"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def sports(lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "sports", lang, "sports.xml"], "/")

    schema = [
      sports: [
        ~x"//sport"el,
        id: ~x"./@id"s,
        name: ~x"./@name"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def categories(sport, lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "sports", lang, "sports", sport, "categories.xml"], "/")

    schema = [
      categories: [
        ~x"//category"el,
        id: ~x"./@id"s,
        name: ~x"./@name"s
      ]
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def tournaments(lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "sports", lang, "tournaments.xml"], "/")

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

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
    |> SweetXml.xmap(schema)
  end

  def tournament_info(tournament, lang \\ "en") do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url, "sports", lang, "tournaments", tournament, "info.xml"], "/")

    schema = [
      # TO-DO: fill in
    ]

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body

    # |> SweetXml.xmap(schema)
  end
end
