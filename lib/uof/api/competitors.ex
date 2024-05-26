defmodule UOF.API.Competitors do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  def show(id, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/competitors/#{id}/profile.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("competitor_profile")
        |> bubble_up("jerseys", "jersey")
        |> bubble_up("players", "player")
        |> UOF.API.Competitors.CompetitorProfile.changeset()
        |> apply

      {:error, _} = error ->
        error
    end
  end
end
