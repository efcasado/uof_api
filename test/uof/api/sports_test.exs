defmodule UOF.API.Sports.Test do
  use ExUnit.Case
  import Mock

  # mock http requests towards Betradar and use recorded responses instead
  setup_with_mocks([
    {UOF.API.Utils.HTTP, [:passthrough],
     [
       get: fn schema, endpoint ->
         {:ok, data} = fetch_mock_data(endpoint)
         Saxaboom.parse(data, schema)
       end
     ]}
  ]) do
    :ok
  end

  defp fetch_mock_data(["sports", _lang, "fixtures", "changes.xml"]) do
    {:ok, File.read!("test/data/fixture_changes.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "results", "changes.xml"]) do
    {:ok, File.read!("test/data/result_changes.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sport_events", _fixture, "summary.xml"]) do
    {:ok, File.read!("test/data/summary.xml")}
  end

  defp fetch_mock_data(["sports", _lang, "sport_events", _fixture, "timeline.xml"]) do
    {:ok, File.read!("test/data/timeline.xml")}
  end

  defp fetch_mock_data(_endpoint) do
    {:error, "mock data not found"}
  end

  ## Static sport event information
  ## =========================================================================

  test "can parse UOF.API.Sports.fixture_changes/{0, 1} response" do
    {:ok, data} = UOF.API.Sports.fixture_changes()

    change = hd(data.changes)

    assert Enum.count(data.changes) == 9543
    assert change.sport_event_id == "sr:match:49540297"
    assert change.update_time == "2024-04-26T19:12:43+00:00"
  end

  test "can parse UOF.API.Sports.result_changes/{0, 1} response" do
    {:ok, data} = UOF.API.Sports.result_changes()

    change = hd(data.changes)

    assert Enum.count(data.changes) == 4236
    assert change.sport_event_id == "sr:match:49689671"
    assert change.update_time == "2024-04-26T19:12:56+00:00"
  end

  ## Sport event information
  ## =========================================================================
  test "can parse 'sports/:lang/sport_events/:fixture/summary.xml' response" do
    {:ok, summary} = UOF.API.Sports.summary("sr:match:42308595")

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

  test "can parse UOF.API.Sports.timeline/{1, 2} response" do
    # TO-DO: pre-match and live samples
    {:ok, timeline} = UOF.API.Sports.timeline("sr:match:42308595")

    # sport event
    assert timeline.sport_event.id == "sr:match:42308595"
    assert timeline.sport_event.scheduled == "2024-04-26T17:30:00+00:00"
    assert timeline.sport_event.start_time_tbd == false
    # sport event -> tournament round
    assert timeline.sport_event.tournament_round.type == "group"
    assert timeline.sport_event.tournament_round.number == "30"
    assert timeline.sport_event.tournament_round.group_long_name == "2nd Bundesliga"
    assert timeline.sport_event.tournament_round.betradar_name == "2nd Bundesliga"
    assert timeline.sport_event.tournament_round.betradar_id == 16956
    # sport event -> season
    assert timeline.sport_event.season.start_date == "2023-09-01"
    assert timeline.sport_event.season.end_date == "2024-06-01"
    assert timeline.sport_event.season.year == "23/24"
    assert timeline.sport_event.season.tournament_id == "sr:tournament:921"
    assert timeline.sport_event.season.id == "sr:season:107905"
    assert timeline.sport_event.season.name == "2. HBL 23/24"
    # sport event -> tournament
    assert timeline.sport_event.tournament.id == "sr:tournament:921"
    assert timeline.sport_event.tournament.name == "2. HBL"
    assert timeline.sport_event.tournament.sport.id == "sr:sport:6"
    assert timeline.sport_event.tournament.sport.name == "Handball"
    assert timeline.sport_event.tournament.category.id == "sr:category:53"
    assert timeline.sport_event.tournament.category.name == "Germany"
    # sport event -> competitors
    [competitor1, competitor2] = timeline.sport_event.competitors
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
    assert timeline.sport_event.venue.id == "sr:venue:7072"
    assert timeline.sport_event.venue.name == "Ischelandhalle"
    assert timeline.sport_event.venue.capacity == 1200
    assert timeline.sport_event.venue.city_name == "Hagen"
    assert timeline.sport_event.venue.country_name == "Germany"
    assert timeline.sport_event.venue.country_code == "DEU"
    assert timeline.sport_event.venue.map_coordinates == "51.370987,7.477113"
    # event conditions
    assert timeline.event_conditions.attendance == 1054
    # event conditions -> venue
    assert timeline.event_conditions.venue.id == "sr:venue:7072"
    assert timeline.event_conditions.venue.name == "Ischelandhalle"
    assert timeline.event_conditions.venue.capacity == 1200
    assert timeline.event_conditions.venue.city_name == "Hagen"
    assert timeline.event_conditions.venue.country_name == "Germany"
    assert timeline.event_conditions.venue.country_code == "DEU"
    assert timeline.event_conditions.venue.map_coordinates == "51.370987,7.477113"
    # event status
    assert timeline.event_status.home_score == 30
    assert timeline.event_status.away_score == 31
    assert timeline.event_status.status_code == 4
    assert timeline.event_status.match_status_code == 100
    assert timeline.event_status.status == "closed"
    assert timeline.event_status.match_status == "ended"
    assert timeline.event_status.winner_id == "sr:competitor:7808"
    # event status -> period scores
    [period1, period2] = timeline.event_status.period_scores
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
    [result] = timeline.event_status.results
    assert result.home_score == 30
    assert result.away_score == 31
    assert result.match_status_code == 100
    # coverage info
    assert timeline.coverage_info.level == "silver"
    assert timeline.coverage_info.live_coverage == true
    assert timeline.coverage_info.covered_from == "venue"
    assert timeline.coverage_info.includes == ["basic_score", "key_events"]
    # events
    assert Enum.count(timeline.events) == 70
    match_started_event = Enum.find(timeline.events, &(&1.type == "match_started"))
    assert match_started_event.id == "1731284211"
    assert match_started_event.time == "2024-04-26T17:33:59+00:00"
    period_start_event = Enum.find(timeline.events, &(&1.type == "period_start"))
    assert period_start_event.id == "1731284217"
    assert period_start_event.time == "2024-04-26T17:33:59+00:00"
    assert period_start_event.period_name == "1st half"
    assert period_start_event.period == 1
    assert period_start_event.match_status_code == 6
    break_start_event = Enum.find(timeline.events, &(&1.type == "break_start"))
    assert break_start_event.id == "1731328687"
    assert break_start_event.time == "2024-04-26T18:13:03+00:00"
    assert break_start_event.period_name == "Pause"
    assert break_start_event.match_status_code == 31
    score_change_event = Enum.find(timeline.events, &(&1.type == "score_change"))
    assert score_change_event.id == "1731285639"
    assert score_change_event.time == "2024-04-26T17:35:12+00:00"
    assert score_change_event.match_time == "2"
    assert score_change_event.match_clock == "1:12"
    assert score_change_event.team == "away"
    assert score_change_event.x == "20"
    assert score_change_event.y == "73"
    assert score_change_event.home_score == 0
    assert score_change_event.away_score == 1
    assert score_change_event.goal_scorer.id == "sr:player:1341258"
    assert score_change_event.goal_scorer.name == "Pehlivan, Doruk"
    [assist] = score_change_event.assists
    assert assist.type == "primary"
    assert assist.id == "sr:player:1554873"
    assert assist.name == "Grzesinski, Mats"
    period_score_event = Enum.find(timeline.events, &(&1.type == "period_score"))
    assert period_score_event.id == "1731328685"
    assert period_score_event.time == "2024-04-26T18:13:03+00:00"
    assert period_score_event.match_clock == "30:00"
    assert period_score_event.home_score == 13
    assert period_score_event.away_score == 16
    assert period_score_event.period == 1
    assert period_score_event.match_status_code == 6
    yellow_card_event = Enum.find(timeline.events, &(&1.type == "yellow_card"))
    assert yellow_card_event.id == "1731307127"
    assert yellow_card_event.time == "2024-04-26T17:53:54+00:00"
    assert yellow_card_event.match_time == "18"
    assert yellow_card_event.match_clock == "17:22"
    assert yellow_card_event.team == "away"
    assert yellow_card_event.player.id == "sr:player:211672"
    assert yellow_card_event.player.name == "Thummler, Jonas"
    match_ended_event = Enum.find(timeline.events, &(&1.type == "match_ended"))
    assert match_ended_event.id == "1731393345"
    assert match_ended_event.time == "2024-04-26T19:10:23+00:00"
    assert match_ended_event.match_clock == "60:00"
  end

  test "can parse 'sports/:lang/tournaments/:tournament/seasons.xml' response" do
    # TO-DO
  end
end
