defmodule UOF.API.Schedules do
  import UOF.API.EctoHelpers
  alias UOF.API.Schedules.Fixture

  def today(lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/schedules/live/schedule.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("schedule")
        |> Map.get("sport_event")
        |> Enum.map(fn x ->
          {:ok, x} = apply(Fixture.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  def at(date, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/schedules/#{date}/schedule.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("schedule")
        |> Map.get("sport_event")
        |> Enum.map(fn x ->
          {:ok, x} = apply(Fixture.changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end
end
