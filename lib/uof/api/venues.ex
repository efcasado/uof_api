defmodule UOF.API.Venues do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  def show(id, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/venues/#{id}/profile.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("venue_summary")
        |> Map.get("venue")
        |> UOF.API.Venues.Venue.changeset()
        |> apply

      {:error, _} = error ->
        error
    end
  end
end
