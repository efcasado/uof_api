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

  # def changed() do
  # end

  # def changed_results() do
  # end

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
end
