defmodule UOF.API.CustomBet.Test do
  use ExUnit.Case
  import Mock

  # mock http requests towards Betradar and use recorded responses instead
  setup_with_mocks([
    {UOF.API.Utils.HTTP, [:passthrough],
     [
       get: fn _schema, _endpoint ->
         data = File.read!("test/data/available_selections.xml")
         Saxaboom.parse(data, %UOF.API.Mappings.CustomBet.AvailableSelections{})
       end,
       post: fn _schema, _endpoint, _body ->
         data = File.read!("test/data/custombet_calculation.xml")
         Saxaboom.parse(data, %UOF.API.Mappings.CustomBet.Calculation{})
       end
     ]}
  ]) do
    :ok
  end

  test "can parse UOF.API.CustomBet.available_selections/1 response" do
    {:ok, available_selections} = UOF.API.CustomBet.available_selections("sr:match:42430779")

    assert available_selections.generated_at == "2024-04-28T17:36:46+00:00"
    assert available_selections.event_id == "sr:match:42430779"
    assert Enum.count(available_selections.markets) == 76
    market = Enum.at(available_selections.markets, 1)
    assert market.id == 87
    assert market.specifiers == "hcp=0:2"
    assert Enum.map(market.outcomes, & &1.id) == ["1711", "1712", "1713"]
  end

  test "can parse UOF.API.CustomBet.calculate/1 response" do
    selections = [{"sr:match:42795059", 97, 74}, {"sr:match:42795059", 10, 9}]
    {:ok, calculation} = UOF.API.CustomBet.calculate(selections)

    assert_in_delta calculation.odds, 5.22, 0.01
    assert_in_delta calculation.probability, 0.15, 0.01
    assert Enum.count(calculation.available_selections.markets) == 76
    market = hd(calculation.available_selections.markets)
    assert market.id == 87
    assert market.specifiers == "hcp=0:2"
    assert Enum.map(market.outcomes, & &1.id) == ["1711", "1712", "1713"]
  end
end
