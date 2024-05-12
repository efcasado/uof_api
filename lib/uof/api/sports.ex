defmodule UOF.API.Sports do
  alias UOF.API.Utils.HTTP

  ## Auxiliary functions
  ## =========================================================================
  def fixtures(filter \\ & &1, map \\ & &1) do
    fixtures(0, 1000, filter, map, [])
  end

  defp fixtures(start, limit, filter, map, acc) do
    {:ok, schedule} = pre_schedule(start, limit)

    case schedule.events do
      [] ->
        acc

      events ->
        # TO-DO: Return subset of fields (eg. only fixture ids)
        # events = maybe_filter_fixtures(events, filter)
        events = for e <- events, filter.(e), do: map.(e)
        fixtures(start + limit, limit, filter, map, events ++ acc)
    end
  end

  # defp maybe_filter_fixtures(fixtures, nil) do
  #   fixtures
  # end
  # defp maybe_filter_fixtures(fixtures, filter) do
  #   Enum.filter(fixtures, filter)
  # end

  def fixtures_by_sport(sports) when is_list(sports) do
    fixtures(&(&1.tournament.sport.name in sports))
  end

  def fixtures_by_sport(sport) do
    fixtures_by_sport([sport])
  end

  ## =========================================================================

  @doc """
  Get the details of the given fixture.
  """
  def fixture(fixture, lang \\ "en") do
    # TO-DO: handle codds fixture (eg. codds:competition_group:77739)
    endpoint = ["sports", lang, "sport_events", fixture, "fixture.xml"]

    HTTP.get(%UOF.API.Mappings.FixturesFixture{}, endpoint)
  end

  @doc """
  Get a list of all the fixtures scheduled to start at the given date (in UTC).
  """
  def schedule(date, lang \\ "en") do
    endpoint = ["sports", lang, "schedules", date, "schedule.xml"]

    HTTP.get(%UOF.API.Mappings.Schedule{}, endpoint)
  end

  @doc """
  Get a list of all live fixtures.
  """
  def live_schedule(lang \\ "en") do
    endpoint = ["sports", lang, "schedules", "live", "schedule.xml"]

    HTTP.get(%UOF.API.Mappings.Schedule{}, endpoint)
  end

  @doc """
  Get a lists of almost all fixtures Betradar offers prematch odds for.
  """
  def pre_schedule(start \\ 0, limit \\ 100, lang \\ "en") do
    endpoint = ["sports", lang, "schedules", "pre", "schedule.xml"]

    HTTP.get(%UOF.API.Mappings.Schedule{}, endpoint, start: start, limit: limit)
  end

  @doc """
  Get the schedule of the given tournament.
  """
  def tournament_schedule(tournament, lang \\ "en") do
    endpoint = ["sports", lang, "tournaments", tournament, "schedule.xml"]

    HTTP.get(%UOF.API.Mappings.Schedule{}, endpoint)
  end

  @doc """
  Get a list of all the fixtures that have changed in the last 24 hours.
  """
  def fixture_changes(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "fixtures", "changes.xml"]

    HTTP.get(%UOF.API.Mappings.FixtureChanges{}, endpoint)
  end

  @doc """
  Get a lists of all the fixtures that have changed results in the last 24 hours.
  """
  def result_changes(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    endpoint = ["sports", lang, "results", "changes.xml"]

    HTTP.get(%UOF.API.Mappings.ResultChanges{}, endpoint)
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

    HTTP.get(%UOF.API.Mappings.Summary{}, endpoint)
  end

  @doc """
  Get detailed information (including event timeline) for the given sport event.
  # Prematch, Live or Post-match. Prematch details are very brief. Post-match
  # details include results.
  """
  def timeline(fixture, lang \\ "en") do
    endpoint = ["sports", lang, "sport_events", fixture, "timeline.xml"]

    HTTP.get(%UOF.API.Mappings.Timeline{}, endpoint)
  end

  def tournaments(lang \\ "en") do
    endpoint = ["sports", lang, "tournaments.xml"]

    HTTP.get(%UOF.API.Mappings.Tournaments{}, endpoint)
  end

  @doc """
  Get details about the given tournament.
  """
  def tournament(tournament, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
    endpoint = ["sports", lang, "tournaments", tournament, "info.xml"]

    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    HTTP.get(%UOF.API.Mappings.TournamentInfo{}, endpoint)
  end

  ## Entity Description
  ## =========================================================================
  @doc """
  Get the details of the given player.
  """
  def player(player, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Player+profile
    endpoint = ["sports", lang, "players", player, "profile.xml"]

    HTTP.get(%UOF.API.Mappings.PlayerProfile{}, endpoint)
  end

  @doc """
  Get the details of the given competitor.
  """
  def competitor(competitor, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Competitors+profile
    endpoint = ["sports", lang, "competitors", competitor, "profile.xml"]

    HTTP.get(%UOF.API.Mappings.CompetitorProfile{}, endpoint)
  end

  @doc """
  Get the details of the given venue.
  """
  def venue(venue, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Venues
    endpoint = ["sports", lang, "venues", venue, "profile.xml"]

    HTTP.get(%UOF.API.Mappings.VenueProfile{}, endpoint)
  end
end
