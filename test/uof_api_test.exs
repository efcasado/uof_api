defmodule UOF.API.Test do
  use ExUnit.Case

  doctest UOF.API

  test "can parse 'descriptions/:lang/markets.xml' response" do
    data = File.read!("test/data/markets.xml")

    {:ok, %UOF.API.Mappings.MarketDescriptions{markets: markets}} =
      Saxaboom.parse(data, %UOF.API.Mappings.MarketDescriptions{})

    market = hd(markets)

    assert Enum.count(markets) == 1172
    assert market.id == 282
    assert market.name == "Innings 1 to 5th top - {$competitor1} total"
    assert market.groups == "all|score|4.5_innings"
    assert Enum.map(market.outcomes, & &1.id) == [13, 12]
  end

  test "can parse 'descriptions/:lang/match_status.xml' response" do
    data = File.read!("test/data/match_status.xml")

    {:ok, %UOF.API.Mappings.MatchStatusDescriptions{statuses: statuses}} =
      Saxaboom.parse(data, %UOF.API.Mappings.MatchStatusDescriptions{})

    assert Enum.count(statuses) == 185

    status1 = Enum.at(statuses, 0)

    assert status1.id == 0
    assert status1.description == "Not started"
    assert status1.period_number == nil
    assert status1.all_sports == true
    assert status1.sports == []

    status2 = Enum.at(statuses, 1)

    assert status2.id == 1
    assert status2.description == "1st period"
    assert status2.period_number == 1
    assert status2.all_sports == false

    assert Enum.map(status2.sports, & &1.id) ==
             [
               "sr:sport:2",
               "sr:sport:4",
               "sr:sport:7",
               "sr:sport:13",
               "sr:sport:24",
               "sr:sport:32",
               "sr:sport:34",
               "sr:sport:131",
               "sr:sport:153",
               "sr:sport:157",
               "sr:sport:195"
             ]
  end

  test "can parse 'descriptions/betstop_reasons.xml' response" do
    data = File.read!("test/data/betstop_reasons.xml")

    {:ok, %UOF.API.Mappings.BetStopReasonDescriptions{reasons: reasons}} =
      Saxaboom.parse(data, %UOF.API.Mappings.BetStopReasonDescriptions{})

    reason = hd(reasons)

    assert Enum.count(reasons) == 90
    assert reason.id == 0
    assert reason.description == "UNKNOWN"
  end

  test "can parse 'descriptions/betting_status.xml' response" do
    data = File.read!("test/data/betting_status.xml")

    {:ok, %UOF.API.Mappings.BettingStatusDescriptions{statuses: statuses}} =
      Saxaboom.parse(data, %UOF.API.Mappings.BettingStatusDescriptions{})

    status = hd(statuses)

    assert Enum.count(statuses) == 7
    assert status.id == 0
    assert status.description == "UNKNOWN"
  end

  test "can parse 'descriptions/void_reasons.xml' response" do
    data = File.read!("test/data/void_reasons.xml")

    {:ok, %UOF.API.Mappings.VoidReasonDescriptions{reasons: reasons}} =
      Saxaboom.parse(data, %UOF.API.Mappings.VoidReasonDescriptions{})

    reason = hd(reasons)

    assert Enum.count(reasons) == 17
    assert reason.id == 0
    assert reason.description == "OTHER"
  end

  test "can parse 'descriptions/producers.xml' response" do
    data = File.read!("test/data/producers.xml")

    {:ok, %UOF.API.Mappings.Producers{producers: producers}} =
      Saxaboom.parse(data, %UOF.API.Mappings.Producers{})

    producer = hd(producers)

    assert Enum.count(producers) == 15
    assert producer.id == 1
    assert producer.name == "LO"
    assert producer.description == "Live Odds"
    assert producer.api_url == "https://stgapi.betradar.com/v1/liveodds/"
    assert producer.active == true
    assert producer.scope == "live"
    assert producer.stateful_recovery_window_in_minutes == 600
  end

  ## Static sport event information
  ## =========================================================================

  test "can parse 'sports/:lang/sport_events/:fixture/fixture.xml' response" do
    data = File.read!("test/data/fixture.xml")

    {:ok, %UOF.API.Mappings.FixturesFixture{fixture: fixture}} =
      Saxaboom.parse(data, %UOF.API.Mappings.FixturesFixture{})

    # fixture attributes
    assert fixture.start_time_confirmed == true
    assert fixture.liveodds == "not_available"
    assert fixture.status == "closed"
    assert fixture.next_live_time == "2016-10-31T18:00:00+00:00"
    assert fixture.id == "sr:match:8696826"
    assert fixture.scheduled == "2016-10-31T18:00:00+00:00"
    assert fixture.start_time_tbd == false
    # tournament round
    assert fixture.tournament_round.type == "group"
    assert fixture.tournament_round.number == "25"
    assert fixture.tournament_round.group_long_name == "Ettan, Sodra"
    assert fixture.tournament_round.betradar_name == "Ettan, Sodra"
    assert fixture.tournament_round.betradar_id == 4301
    # season
    assert fixture.season.start_date == "2016-04-16"
    assert fixture.season.end_date == "2016-11-05"
    assert fixture.season.year == "2016"
    assert fixture.season.tournament_id == "sr:tournament:68"
    assert fixture.season.id == "sr:season:12346"
    assert fixture.season.name == "Div 1, Sodra 2016"
    # tournament
    assert fixture.tournament.id == "sr:tournament:68"
    assert fixture.tournament.name == "Ettan, Sodra"
    assert fixture.tournament.sport.id == "sr:sport:1"
    assert fixture.tournament.sport.name == "Soccer"
    assert fixture.tournament.category.id == "sr:category:9"
    assert fixture.tournament.category.name == "Sweden"
    # competitors
    [competitor1, competitor2] = fixture.competitors
    assert competitor1.qualifier == "home"
    assert competitor1.id == "sr:competitor:1860"
    assert competitor1.name == "IK Oddevold"
    assert competitor1.abbreviation == "ODD"
    assert competitor1.short_name == "Oddevold"
    assert competitor1.country == "Sweden"
    assert competitor1.country_code == "SWE"
    assert competitor1.gender == "male"
    assert competitor2.qualifier == "away"
    assert competitor2.id == "sr:competitor:22356"
    assert competitor2.name == "Tvaakers IF"
    assert competitor2.abbreviation == "TVA"
    assert competitor2.short_name == "Tvaakers"
    assert competitor2.country == "Sweden"
    assert competitor2.country_code == "SWE"
    assert competitor2.gender == "male"
    # tv channels
    assert fixture.tv_channels == []
    # extra info
    [info1, info2, info3, info4, info5, info6, info7] = fixture.extra_info
    assert info1.key == "RTS"
    assert info1.value == "not_available"
    assert info2.key == "coverage_source"
    assert info2.value == "venue"
    assert info3.key == "extended_live_markets_offered"
    assert info3.value == "false"
    assert info4.key == "streaming"
    assert info4.value == "false"
    assert info5.key == "auto_traded"
    assert info5.value == "false"
    assert info6.key == "neutral_ground"
    assert info6.value == "false"
    assert info7.key == "period_length"
    assert info7.value == "45"
    # product info
    # TO-DO: implement
    # reference ids
    [reference] = fixture.references
    assert reference.name == "BetradarCtrl"
    assert reference.value == "11428313"
  end

  test "can parse 'sports/:lang/fixtures/changes.xml' response" do
    data = File.read!("test/data/fixture_changes.xml")

    {:ok, %UOF.API.Mappings.FixtureChanges{changes: changes}} =
      Saxaboom.parse(data, %UOF.API.Mappings.FixtureChanges{})

    change = hd(changes)

    assert Enum.count(changes) == 9543
    assert change.sport_event_id == "sr:match:49540297"
    assert change.update_time == "2024-04-26T19:12:43+00:00"
  end

  test "can parse 'sports/:lang/results/changes.xml' response" do
    data = File.read!("test/data/result_changes.xml")

    {:ok, %UOF.API.Mappings.ResultChanges{changes: changes}} =
      Saxaboom.parse(data, %UOF.API.Mappings.ResultChanges{})

    change = hd(changes)

    assert Enum.count(changes) == 4236
    assert change.sport_event_id == "sr:match:49689671"
    assert change.update_time == "2024-04-26T19:12:56+00:00"
  end

  ## Sport event information
  ## =========================================================================
  test "can parse 'sports/:lang/sport_events/:fixture/summary.xml' response" do
    data = File.read!("test/data/summary.xml")

    {:ok, summary} = Saxaboom.parse(data, %UOF.API.Mappings.Summary{})

    # sport event
    assert summary.sport_event.id == "sr:match:42308595"
    assert summary.sport_event.scheduled == "2024-04-26T17:30:00+00:00"
    assert summary.sport_event.start_time_tbd == false
    # sport event -> tournament round
    assert summary.sport_event.tournament_round.type == "group"
    assert summary.sport_event.tournament_round.number == "30"
    assert summary.sport_event.tournament_round.group_long_name == "2nd Bundesliga"
    assert summary.sport_event.tournament_round.betradar_name == "2nd Bundesliga"
    assert summary.sport_event.tournament_round.betradar_id == 16956
    # sport event -> season
    assert summary.sport_event.season.start_date == "2023-09-01"
    assert summary.sport_event.season.end_date == "2024-06-01"
    assert summary.sport_event.season.year == "23/24"
    assert summary.sport_event.season.tournament_id == "sr:tournament:921"
    assert summary.sport_event.season.id == "sr:season:107905"
    assert summary.sport_event.season.name == "2. HBL 23/24"
    # sport event -> tournament
    assert summary.sport_event.tournament.id == "sr:tournament:921"
    assert summary.sport_event.tournament.name == "2. HBL"
    assert summary.sport_event.tournament.sport.id == "sr:sport:6"
    assert summary.sport_event.tournament.sport.name == "Handball"
    assert summary.sport_event.tournament.category.id == "sr:category:53"
    assert summary.sport_event.tournament.category.name == "Germany"
    # sport event -> competitors
    [competitor1, competitor2] = summary.sport_event.competitors
    assert competitor1.qualifier == "home"
    assert competitor1.id == "sr:competitor:6325"
    assert competitor1.name == "VfL Eintracht Hagen"
    assert competitor1.abbreviation == "HAG"
    assert competitor1.short_name == "Eintracht Hagen"
    assert competitor1.country == "Germany"
    assert competitor1.country_code == "DEU"
    assert competitor1.gender == "male"
    [c1_ref] = competitor1.references
    assert c1_ref.name == "betradar"
    assert c1_ref.value == "8042520"
    assert competitor2.qualifier == "away"
    assert competitor2.id == "sr:competitor:7808"
    assert competitor2.name == "HC Elbflorenz 2006"
    assert competitor2.abbreviation == "ELB"
    assert competitor2.short_name == "Elbflorenz 2006"
    assert competitor2.country == "Germany"
    assert competitor2.country_code == "DEU"
    assert competitor2.gender == "male"
    [c2_ref] = competitor2.references
    assert c2_ref.name == "betradar"
    assert c2_ref.value == "9919108"
    # sport event -> venue
    assert summary.sport_event.venue.id == "sr:venue:7072"
    assert summary.sport_event.venue.name == "Ischelandhalle"
    assert summary.sport_event.venue.capacity == 1200
    assert summary.sport_event.venue.city_name == "Hagen"
    assert summary.sport_event.venue.country_name == "Germany"
    assert summary.sport_event.venue.country_code == "DEU"
    assert summary.sport_event.venue.map_coordinates == "51.370987,7.477113"
    # event conditions
    assert summary.event_conditions.attendance == 1054
    # event conditions -> venue
    assert summary.event_conditions.venue.id == "sr:venue:7072"
    assert summary.event_conditions.venue.name == "Ischelandhalle"
    assert summary.event_conditions.venue.capacity == 1200
    assert summary.event_conditions.venue.city_name == "Hagen"
    assert summary.event_conditions.venue.country_name == "Germany"
    assert summary.event_conditions.venue.country_code == "DEU"
    assert summary.event_conditions.venue.map_coordinates == "51.370987,7.477113"
    # event status
    assert summary.event_status.home_score == 30
    assert summary.event_status.away_score == 31
    assert summary.event_status.status_code == 4
    assert summary.event_status.match_status_code == 100
    assert summary.event_status.status == "closed"
    assert summary.event_status.match_status == "ended"
    assert summary.event_status.winner_id == "sr:competitor:7808"
    # event status -> period scores
    [period1, period2] = summary.event_status.period_scores
    assert period1.home_score == 13
    assert period1.away_score == 16
    assert period1.match_status_code == 6
    assert period1.type == "regular_period"
    assert period1.number == 1
    assert period2.home_score == 17
    assert period2.away_score == 15
    assert period2.match_status_code == 7
    assert period2.type == "regular_period"
    assert period2.number == 2
    # event status -> results
    [result] = summary.event_status.results
    assert result.home_score == 30
    assert result.away_score == 31
    assert result.match_status_code == 100
    # coverage info
    assert summary.coverage_info.level == "silver"
    assert summary.coverage_info.live_coverage == true
    assert summary.coverage_info.covered_from == "venue"
    assert summary.coverage_info.includes == ["basic_score", "key_events"]
  end

  test "can parse 'sports/:lang/sport_events/:fixture/timeline.xml' response" do
    # TO-DO
  end

  test "can parse 'sports/:lang/sports/:sport/categories.xml' response" do
    data = File.read!("test/data/categories.xml")

    {:ok, sport_categories} = Saxaboom.parse(data, %UOF.API.Mappings.SportCategories{})

    # sport
    sport = sport_categories.sport
    assert sport.id == "sr:sport:1"
    assert sport.name == "Soccer"
    # categories
    categories = sport_categories.categories
    category = hd(categories)
    assert Enum.count(categories) == 224
    assert category.id == "sr:category:1"
    assert category.name == "England"
    assert category.country_code == "ENG"
  end

  test "can parse 'sports/:lang/sports/tournaments.xml' response" do
    # TO-DO
  end

  test "can parse 'sports/:lang/sports/:sport/tournaments.xml' response" do
    data = File.read!("test/data/tournaments.xml")

    {:ok, %UOF.API.Mappings.Tournaments{tournaments: tournaments}} =
      Saxaboom.parse(data, %UOF.API.Mappings.Tournaments{})

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
    season_coverage = tournament.season_coverage
    assert season_coverage.season_id == "sr:season:106479"
    assert season_coverage.scheduled == 215
    assert season_coverage.played == 210
    assert season_coverage.max_covered == 136
    assert season_coverage.max_coverage_level == "gold"
    assert season_coverage.min_coverage_level == "silver"
  end

  test "can parse 'sports/:lang/sports.xml' response" do
    data = File.read!("test/data/sports.xml")

    {:ok, %UOF.API.Mappings.Sports{sports: sports}} =
      Saxaboom.parse(data, %UOF.API.Mappings.Sports{})

    sport = hd(sports)

    assert Enum.count(sports) == 204
    assert sport.id == "sr:sport:143"
    assert sport.name == "7BallRun"
  end

  test "can parse 'sports/:lang/tournaments/:tournament/info.xml' response" do
    data = File.read!("test/data/tournament_info.xml")

    {:ok, info} = Saxaboom.parse(data, %UOF.API.Mappings.TournamentInfo{})

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

  test "can parse 'sports/:lang/tournaments/:tournament/seasons.xml' response" do
    # TO-DO
  end

  ## Entity descriptions
  ## =========================================================================
  test "can parse 'sports/:lang/player/:player/profile.xml' response" do
    data = File.read!("test/data/player_profile.xml")

    {:ok, profile} = Saxaboom.parse(data, %UOF.API.Mappings.PlayerProfile{})

    assert profile.player.date_of_birth == "1973-08-29"
    assert profile.player.nationality == "Germany"
    assert profile.player.country_code == "DEU"
    assert profile.player.full_name == "Thomas Tuchel"
    assert profile.player.gender == "male"
    assert profile.player.id == "sr:player:72771"
    assert profile.player.name == "Tuchel, Thomas"
  end

  test "can parse 'sports/:lang/competitor/:competitor/profile.xml' response" do
    data = File.read!("test/data/competitor_profile.xml")

    {:ok, profile} = Saxaboom.parse(data, %UOF.API.Mappings.CompetitorProfile{})

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

  test "can parse 'sports/:lang/venue/:venue/venue.xml' response" do
    data = File.read!("test/data/venue_profile.xml")

    {:ok, profile} = Saxaboom.parse(data, %UOF.API.Mappings.VenueProfile{})

    # venue
    assert profile.venue.id == "sr:venue:574"
    assert profile.venue.name == "Allianz Arena"
    assert profile.venue.capacity == 75000
    assert profile.venue.city_name == "Munich"
    assert profile.venue.country_name == "Germany"
    assert profile.venue.country_code == "DEU"
    assert profile.venue.map_coordinates == "48.218777,11.624748"
    # home teams
    home_team = hd(profile.home_teams)
    assert Enum.count(profile.home_teams) == 1
    assert home_team.id == "sr:competitor:2672"
    assert home_team.name == "Bayern Munich"
    assert home_team.abbreviation == "BMU"
    assert home_team.country == "Germany"
    assert home_team.country_code == "DEU"
    assert home_team.gender == "male"
  end
end
