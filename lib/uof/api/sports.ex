defmodule UOF.API.Sports do
  @moduledoc """
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  alias UOF.API.Utils.HTTP

  @doc """
  List all the available sports.
  """
  # @spec all(lang :: String.t()) :: list(__MODULE__.t())
  def all(lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/sports.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("sports")
        |> Map.get("sport")
        |> Enum.map(fn x ->
          {:ok, x} = apply(UOF.API.Sports.Sport.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @doc """
  List all the available categories for the given sport.
  """
  # @spec categories(sport :: String.t(), lang :: String.t()) :: list(__MODULE__.t())
  def categories(sport, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/sports/#{sport}/categories.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("sport_categories")
        |> Map.get("categories")
        |> Map.get("category")
        |> Enum.map(fn x ->
          {:ok, x} = apply(UOF.API.Sports.Category.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

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
end
