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

  test "can parse 'sports/:lang/sports.xml' response" do
    data = File.read!("test/data/sports.xml")

    {:ok, %UOF.API.Mappings.Sports{sports: sports}} =
      Saxaboom.parse(data, %UOF.API.Mappings.Sports{})

    sport = hd(sports)

    assert Enum.count(sports) == 204
    assert sport.id == "sr:sport:143"
    assert sport.name == "7BallRun"
  end

  ## Static sport event information
  ##=========================================================================

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
end
