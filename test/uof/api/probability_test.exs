defmodule UOF.API.Probability.Test do
  use ExUnit.Case
  import Mock

  # mock http requests towards Betradar and use recorded responses instead
  setup_with_mocks([
    {UOF.API.Utils.HTTP, [:passthrough],
     [
       get: fn schema, _endpoint ->
         data = File.read!("test/data/cashout.xml")
         Saxaboom.parse(data, schema)
       end
     ]}
  ]) do
    :ok
  end

  test "can parse UOF.API.Probability.probabilities/1" do
    {:ok, cashout} = UOF.API.Probability.probabilities("sr:match:41878167")

    assert cashout.event_status.status == 1
    assert cashout.event_status.match_status == 7
    assert Enum.count(cashout.markets) == 162
    [market1, market2 | _] = cashout.markets
    assert market1.status == -3
    assert market1.cashout_status == -2
    assert market1.id == 66
    assert market1.specifiers == "hcp=0.5"
    assert market1.outcomes == []
    assert market2.status == 1
    assert market2.cashout_status == 1
    assert market2.id == 547
    assert market2.specifiers == "total=4.5"
    assert Enum.count(market2.outcomes) == 6
    outcome = hd(market2.outcomes)
    assert outcome.id == "1729"
    assert outcome.active == 1
    assert_in_delta outcome.probability, 3.58e-4, 0.01e-4
  end
end
