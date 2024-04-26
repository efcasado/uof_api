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
end
