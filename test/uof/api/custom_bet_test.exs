defmodule UOF.API.CustomBet.Test do
  use ExUnit.Case
  import Mock

  # mock http requests towards Betradar and use recorded responses instead
  setup_with_mocks([
    {UOF.API.Utils.HTTP, [:passthrough],
     [
       get: fn schema, _endpoint ->
         data = File.read!("test/data/available_selections.xml")
         UOF.API.XML.decode(data, schema)
       end,
       post: fn schema, _endpoint, _body ->
         data = File.read!("test/data/custombet_calculation.xml")
         UOF.API.XML.decode(data, schema)
       end
     ]}
  ]) do
    :ok
  end

  test "can parse UOF.API.CustomBet.available_selections/1 response" do
    {:ok, available_selections} = UOF.API.CustomBet.available_selections("sr:match:42430779")

    assert available_selections.generated_at == ~U[2024-04-28 17:36:46Z]
    assert available_selections.event.id == "sr:match:42430779"

    markets = available_selections.event.markets.market
    assert Enum.count(markets) == 76
    market = Enum.at(markets, 1)
    assert market.id == 87
    assert market.specifiers == "hcp=0:2"
    assert Enum.map(market.outcome, & &1.id) == ["1711", "1712", "1713"]
  end

  test "can parse UOF.API.CustomBet.calculate/1 response" do
    selections = [{"sr:match:42795059", 97, 74}, {"sr:match:42795059", 10, 9}]
    {:ok, calculation} = UOF.API.CustomBet.calculate(selections)

    assert_in_delta Decimal.to_float(calculation.calculation.odds), 5.22, 0.01
    assert_in_delta Decimal.to_float(calculation.calculation.probability), 0.15, 0.01

    event = hd(calculation.available_selections.event)
    markets = event.markets.market
    assert Enum.count(markets) == 76
    market = hd(markets)
    assert market.id == 87
    assert market.specifiers == "hcp=0:2"
    assert Enum.map(market.outcome, & &1.id) == ["1711", "1712", "1713"]
  end
end
