defmodule UOF.API.Sports.Tournament.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get, url: "/sports/en/tournaments.xml"} ->
        resp = File.read!("test/data/tournaments.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}

      %{method: :get, url: "/sports/en/tournaments/sr:tournament:7/info.xml"} ->
        resp = File.read!("test/data/tournament_info.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Sports.Tournament.all/{0, 1} response" do
    tournaments = UOF.API.Sports.Tournament.all()

    tournament = Enum.at(tournaments, 2)

    # tournament attributes
    assert Enum.count(tournaments) == 1312
    assert tournament.id == "sr:tournament:7"
    assert tournament.name == "UEFA Champions League"
    # tournament -> sport
    sport = tournament.sport
    assert sport.id == "sr:sport:1"
    assert sport.name == "Soccer"
    # tournament -> category
    category = tournament.category
    assert category.id == "sr:category:393"
    assert category.name == "International Clubs"
    # tournament -> current season
    current_season = tournament.current_season
    assert current_season.start_date == "2023-06-27"
    assert current_season.end_date == "2024-06-01"
    assert current_season.year == "23/24"
    assert current_season.id == "sr:season:106479"
    # tournament -> season coverage
    season_coverage = tournament.season_coverage_info
    assert season_coverage.season_id == "sr:season:106479"
    assert season_coverage.scheduled == 215
    assert season_coverage.played == 210
    assert season_coverage.max_covered == 136
    assert season_coverage.max_coverage_level == "gold"
    assert season_coverage.min_coverage_level == "silver"
  end

  test "can parse UOF.API.Sports.Tournament.show/{1, 2} response" do
    {:ok, info} = UOF.API.Sports.Tournament.show("sr:tournament:7")

    # tournament
    assert info.tournament.id == "sr:tournament:7"
    assert info.tournament.name == "UEFA Champions League"
    # tournament -> sport
    assert info.tournament.sport.id == "sr:sport:1"
    assert info.tournament.sport.name == "Soccer"
    # tournament -> category
    assert info.tournament.category.id == "sr:category:393"
    assert info.tournament.category.name == "International Clubs"
    # tournament -> current season
    assert info.tournament.current_season.start_date == "2023-06-27"
    assert info.tournament.current_season.end_date == "2024-06-01"
    assert info.tournament.current_season.year == "23/24"
    assert info.tournament.current_season.id == "sr:season:106479"
    # season
    assert info.season.start_date == "2023-06-27"
    assert info.season.end_date == "2024-06-01"
    assert info.season.year == "23/24"
    assert info.season.id == "sr:season:106479"
    assert info.season.name == "UEFA Champions League 23/24"
    # round
    assert info.round.type == "cup"
    assert info.round.name == "Quarterfinal"
    assert info.round.cup_round_matches == 2
    assert info.round.cup_round_match_number == 2
    # coverage info
    assert info.coverage_info.live_coverage == true
    # groups
    group = hd(info.groups)
    assert Enum.count(info.groups) == 9
    assert group.name == "A"
    assert group.id == "sr:group:74525"
    # group -> competitors
    # * competitors
    assert Enum.count(group.competitors) == 4
    competitor = hd(group.competitors)
    assert competitor.id == "sr:competitor:2672"
    assert competitor.name == "Bayern Munich"
    assert competitor.abbreviation == "BMU"
    assert competitor.country == "Germany"
    assert competitor.country_code == "DEU"
    assert competitor.gender == "male"
    [reference] = competitor.references
    assert reference.name == "betradar"
    assert reference.value == "6631"
  end
end
