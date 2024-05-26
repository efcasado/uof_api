defmodule UOF.API.Players.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/player_profile.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Players.show/{1, 2} response" do
    {:ok, player} = UOF.API.Players.show("sr:player:72771")

    assert player.date_of_birth == "1973-08-29"
    assert player.nationality == "Germany"
    assert player.country_code == "DEU"
    assert player.full_name == "Thomas Tuchel"
    assert player.gender == "male"
    assert player.id == "sr:player:72771"
    assert player.name == "Tuchel, Thomas"
  end
end
