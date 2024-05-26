defmodule UOF.API.Fixtures do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all the available fixtures.
  """
  def all(lang \\ "en", filter \\ & &1, map \\ & &1) do
    all(lang, 0, 1000, filter, map, [])
  end

  defp all(lang, start, limit, filter, map, acc) do
    case pre_schedule(lang, start, limit) do
      [] ->
        acc

      events ->
        # TO-DO: Return subset of fields (eg. only fixture ids)
        # events = maybe_filter_fixtures(events, filter)
        events = for e <- events, filter.(e), do: map.(e)
        all(lang, start + limit, limit, filter, map, events ++ acc)
    end
  end

  defp pre_schedule(lang \\ "en", start \\ 0, limit \\ 100) do
    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    case UOF.API.get("/sports/#{lang}/schedules/pre/schedule.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("schedule")
        |> Map.get("sport_event")
        |> Enum.map(fn x ->
          {:ok, x} = apply(UOF.API.Schedules.Fixture.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Get a list of all the fixtures that have changed in the last 24 hours.
  """
  def changed(lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/fixtures/changes.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("fixture_changes")
        |> Map.get("fixture_change")
        |> Enum.map(fn x ->
          {:ok, x} = apply(UOF.API.Fixtures.Change.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Get a lists of all the fixtures that have changed results in the last 24 hours.
  """
  def changed_result(lang \\ "en") do
    # TO-DO: add support for 'after datetime' and 'sport' filters
    case UOF.API.get("/sports/#{lang}/results/changes.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("result_changes")
        |> Map.get("result_change")
        |> Enum.map(fn x ->
          {:ok, x} = apply(UOF.API.Fixtures.Change.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Get the details of the given fixture.
  """
  def show(id, lang \\ "en") do
    # TO-DO: handle codds fixture (eg. codds:competition_group:77739)
    case UOF.API.get("/sports/#{lang}/sport_events/#{id}/fixture.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("fixtures_fixture")
        |> Map.get("fixture")
        |> bubble_up("competitors", "competitor")
        |> bubble_up("extra_info", "info")
        |> bubble_up("reference_ids", "reference_id")
        |> IO.inspect()
        |> UOF.API.Fixtures.Fixture.changeset()
        |> apply

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Get information and results for the given fixture.
  """
  def summary(id, lang \\ "en") do
    # https://docs.betradar.com/display/BD/UOF+-+Summary+end+point
    # TO-DO: differentiate between match and race summaries
    case UOF.API.get("/sports/#{lang}/sport_events/#{id}/summary.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> IO.inspect()
        |> Map.get("match_summary")
        # |> Map.get("fixture")
        # |> bubble_up("competitors", "competitor")
        # |> bubble_up("extra_info", "info")
        # |> bubble_up("reference_ids", "reference_id")
        |> rename("sport_event", "fixture")

      # |> UOF.API.Fixtures.Fixture.Summary.changeset()
      # |> apply

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Get detailed information (including event timeline) for the given sport event.
  # Prematch, Live or Post-match. Prematch details are very brief. Post-match
  # details include results.
  """
  def timeline(id, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/sport_events/#{id}/timeline.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> IO.inspect()
        |> Map.get("match_timeline")
        |> rename("sport_event", "fixture")

      # |> bubble_up("competitors", "competitor")
      # |> bubble_up("extra_info", "info")
      # |> bubble_up("reference_ids", "reference_id")
      # |> IO.inspect()
      # |> UOF.API.Fixtures.Fixture.Summary.changeset()
      # |> apply

      {:error, _} = error ->
        error
    end
  end
end
