defmodule UOF.API.Descriptions.Test do
  use ExUnit.Case
  import Mock

  # mock http requests towards Betradar and use recorded responses instead
  setup_with_mocks([
    {UOF.API.Utils.HTTP, [:passthrough],
     [
       get: fn schema, endpoint ->
         data = File.read!("test/data/" <> Enum.at(endpoint, -1))
         Saxaboom.parse(data, schema)
       end
     ]}
  ]) do
    :ok
  end

  test "can parse UOF.API.Descriptions.markets/{0, 1} response" do
    {:ok, desc} = UOF.API.Descriptions.markets()

    market = hd(desc.markets)

    assert Enum.count(desc.markets) == 1172
    assert market.id == 282
    assert market.name == "Innings 1 to 5th top - {$competitor1} total"
    assert market.groups == "all|score|4.5_innings"
    assert Enum.map(market.outcomes, & &1.id) == ["13", "12"]
  end

  test "can parse UOF.API.Descriptions.match_statuses/{0, 1} response" do
    {:ok, desc} = UOF.API.Descriptions.match_statuses()

    assert Enum.count(desc.statuses) == 185

    status1 = Enum.at(desc.statuses, 0)

    assert status1.id == 0
    assert status1.description == "Not started"
    assert status1.period_number == nil
    assert status1.all_sports == true
    assert status1.sports == []

    status2 = Enum.at(desc.statuses, 1)

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

  test "can parse UOF.API.Descriptions.betstop_reasons/0 response" do
    {:ok, desc} = UOF.API.Descriptions.betstop_reasons()

    reason = hd(desc.reasons)

    assert Enum.count(desc.reasons) == 90
    assert reason.id == 0
    assert reason.description == "UNKNOWN"
  end

  test "can parse UOF.API.Descriptions.betting_statuses/0 response" do
    {:ok, desc} = UOF.API.Descriptions.betting_statuses()

    status = hd(desc.statuses)

    assert Enum.count(desc.statuses) == 7
    assert status.id == 0
    assert status.description == "UNKNOWN"
  end

  test "can parse UOF.API.Descriptions.void_reasons/0 response" do
    {:ok, desc} = UOF.API.Descriptions.void_reasons()

    reason = hd(desc.reasons)

    assert Enum.count(desc.reasons) == 17
    assert reason.id == 0
    assert reason.description == "OTHER"
  end

  test "can parse UOF.API.Descriptions.variants/{0, 1} response" do
    {:ok, desc} = UOF.API.Descriptions.variants()

    assert Enum.count(desc.variants) == 144
    variant = hd(desc.variants)
    assert variant.id == "sr:correct_score:after:4"
    assert Enum.count(variant.outcomes) == 5
    outcome = hd(variant.outcomes)
    assert outcome.id == "sr:correct_score:after:4:1530"
    assert outcome.name == "4:0"
    assert Enum.count(variant.mappings) == 1
    mapping = hd(variant.mappings)
    assert mapping.product_id == 3
    assert mapping.product_ids == "3"
    assert mapping.sport_id == "sr:sport:22"
    assert mapping.market_id == 1262
    assert mapping.product_market_id == "960"
    assert Enum.count(mapping.outcome_mappings) == 5
    outcome_mapping = hd(mapping.outcome_mappings)
    assert outcome_mapping.outcome_id == "sr:correct_score:after:4:1530"
    assert outcome_mapping.product_outcome_id == "26"
    assert outcome_mapping.product_outcome_name == "4:0"
  end

  test "can parse UOF.API.Descriptions.producers/0 response" do
    {:ok, desc} = UOF.API.Descriptions.producers()

    producer = hd(desc.producers)

    assert Enum.count(desc.producers) == 15
    assert producer.id == 1
    assert producer.name == "LO"
    assert producer.description == "Live Odds"
    assert producer.api_url == "https://stgapi.betradar.com/v1/liveodds/"
    assert producer.active == true
    assert producer.scope == "live"
    assert producer.stateful_recovery_window_in_minutes == 600
  end
end
