defmodule UOF.API do
  # https://docs.betradar.com/display/BD/UOF+-+Endpoints
  alias UOF.API.Utils.HTTP

  ## Betting Descriptions
  ## =========================================================================

  @doc """
  Describe all currently available markets.
  """
  def markets(lang \\ "en") do
    # TO-DO: Optional mappings
    endpoint = ["descriptions", lang, "markets.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.MarketDescriptions{})
  end

  @doc """
  Describe all sport-specific match status codes used during live matches in
  `odds_change` messages.
  """
  def match_statuses(lang \\ "en") do
    endpoint = ["descriptions", lang, "match_status.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.MatchStatusDescriptions{})
  end

  @doc """
  Describe all bet stop reasons.
  """
  @spec betstop_reasons :: {:ok, UOF.API.Mappings.BetStopReasonDescription.t()}
  def betstop_reasons do
    endpoint = ["descriptions", "betstop_reasons.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.BetStopReasonDescriptions{})
  end

  @doc """
  Describes all betting statuses used in `odds_change` messages.
  """
  def betting_statuses do
    endpoint = ["descriptions", "betting_status.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.BettingStatusDescriptions{})
  end

  @doc """
  Describe all currently avbailable producers and their ids.
  """
  def producers do
    endpoint = ["descriptions", "producers.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.Producers{})
  end

  @doc """
  Describe all possible void reasons used in `bet_settlement` messages.
  """
  def void_reasons do
    endpoint = ["descriptions", "void_reasons.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.VoidReasonDescriptions{})
  end

  ## Static Sport Event Information
  ## =========================================================================

  @doc """
  Get the details of the given fixture.
  """
  def fixture(fixture, lang \\ "en") do
    # TO-DO: handle codds fixture (eg. codds:competition_group:77739)
    endpoint = ["sports", lang, "sport_events", fixture, "fixture.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.FixturesFixture{})
  end

  # date = "live | <date> | pre (start, limit)"
  def schedule(date, lang \\ "en") do
    endpoint = ["sports", lang, "schedules", date, "schedule.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.Schedule{})
  end

  def fixture_changes(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "fixtures", "changes.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.FixtureChanges{})
  end

  @doc """
  Get a list of all fixtures with result changes.
  """
  def results(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "results", "changes.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.ResultChanges{})
  end

  ## Sport Event Information
  ## =========================================================================

  @doc """
  Get information and results for the given fixture.
  """
  def summary(fixture, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Summary+end+point
    # TO-DO: differentiate between match and race summaries
    endpoint = ["sports", lang, "sport_events", fixture, "summary.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.Summary{})
  end

  @doc """
  List all the available sports.
  """
  def sports(lang \\ "en") do
    endpoint = ["sports", lang, "sports.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.Sports{})
  end

  @doc """
  List all the available categories for the given sport.
  """
  def categories(sport, lang \\ "en") do
    endpoint = ["sports", lang, "sports", sport, "categories.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.SportCategories{})
  end

  def tournaments(lang \\ "en") do
    endpoint = ["sports", lang, "tournaments.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.Tournaments{})
  end

  @doc """
  Get details about the given tournament.
  """
  def tournament(tournament, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
    endpoint = ["sports", lang, "tournaments", tournament, "info.xml"]

    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    HTTP.get(endpoint, %UOF.API.Mappings.TournamentInfo{})
  end

  ## Entity Description
  ## =========================================================================
  @doc """
  Get the details of the given player.
  """
  def player(player, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Player+profile
    endpoint = ["sports", lang, "players", player, "profile.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.PlayerProfile{})
  end

  @doc """
  Get the details of the given competitor.
  """
  def competitor(competitor, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Competitors+profile
    endpoint = ["sports", lang, "competitors", competitor, "profile.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.CompetitorProfile{})
  end

  @doc """
  Get the details of the given venue.
  """
  def venue(venue, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Venues
    endpoint = ["sports", lang, "venues", venue, "profile.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.VenueProfile{})
  end

  ## User Information
  ## =========================================================================

  @doc """
  Get information about the token being used.
  """
  def whoami do
    endpoint = ["users", "whoami.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.BookmakerDetails{})
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
