defmodule UOF.API.Players do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  def show(id, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/players/#{id}/profile.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("player_profile")
        |> Map.get("player")
        |> UOF.API.Players.Player.changeset()
        |> apply

      {:error, _} = error ->
        error
    end
  end
end
