defmodule UOF.API.Competitors.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/competitor_profile.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Competitors.show/{1, 2} response" do
    {:ok, profile} = UOF.API.Competitors.show("sr:competitor:2672")

    # competitor
    assert profile.competitor.id == "sr:competitor:2672"
    assert profile.competitor.name == "Bayern Munich"
    assert profile.competitor.abbreviation == "BMU"
    assert profile.competitor.country == "Germany"
    assert profile.competitor.country_code == "DEU"
    assert profile.competitor.gender == "male"
    # competitor -> sport
    assert profile.competitor.sport.id == "sr:sport:1"
    assert profile.competitor.sport.name == "Soccer"
    # competitor -> category
    assert profile.competitor.category.id == "sr:category:30"
    assert profile.competitor.category.name == "Germany"
    assert profile.competitor.category.country_code == "DEU"
    # venue
    assert profile.venue.id == "sr:venue:574"
    assert profile.venue.name == "Allianz Arena"
    assert profile.venue.capacity == 75000
    assert profile.venue.city_name == "Munich"
    assert profile.venue.country_name == "Germany"
    assert profile.venue.country_code == "DEU"
    assert profile.venue.map_coordinates == "48.218777,11.624748"
    # jerseys
    jersey = hd(profile.jerseys)
    assert Enum.count(profile.jerseys) == 4
    assert jersey.type == "home"
    assert jersey.base == "fdfcfc"
    assert jersey.sleeve == "ff0000"
    assert jersey.number == "f90606"
    assert jersey.stripes == false
    assert jersey.horizontal_stripes == false
    assert jersey.squares == false
    assert jersey.split == false
    assert jersey.shirt_type == "short_sleeves"
    # manager
    assert profile.manager.id == "sr:player:72771"
    assert profile.manager.name == "Tuchel, Thomas"
    assert profile.manager.nationality == "Germany"
    assert profile.manager.country_code == "DEU"
    # players
    player = hd(profile.players)
    assert Enum.count(profile.players) == 32
    assert player.type == "goalkeeper"
    assert player.date_of_birth == "1986-03-27"
    assert player.nationality == "Germany"
    assert player.country_code == "DEU"
    assert player.height == 193
    assert player.weight == 93
    assert player.jersey_number == 1
    assert player.full_name == "Manuel Peter Neuer"
    assert player.gender == "male"
    assert player.id == "sr:player:8959"
    assert player.name == "Neuer, Manuel"
  end
end
