defmodule UOF.API.Venues.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/venue_profile.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Sports.venue/{1, 2} response" do
    {:ok, venue} = UOF.API.Venues.show("sr:venue:574")

    # venue
    assert venue.id == "sr:venue:574"
    assert venue.name == "Allianz Arena"
    assert venue.capacity == 75000
    assert venue.city_name == "Munich"
    assert venue.country_name == "Germany"
    assert venue.country_code == "DEU"
    assert venue.map_coordinates == "48.218777,11.624748"
    # # home teams
    # home_team = hd(profile.home_teams)
    # assert Enum.count(profile.home_teams) == 1
    # assert home_team.id == "sr:competitor:2672"
    # assert home_team.name == "Bayern Munich"
    # assert home_team.abbreviation == "BMU"
    # assert home_team.country == "Germany"
    # assert home_team.country_code == "DEU"
    # assert home_team.gender == "male"
  end
end
