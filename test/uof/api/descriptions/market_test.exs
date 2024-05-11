defmodule UOF.API.Descriptions.Market.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/markets.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.Market.all/0 response" do
    resp = UOF.API.Descriptions.Market.all()

    assert Enum.count(resp) == 1172
    assert hd(resp).id == 282
    assert hd(resp).name == "Innings 1 to 5th top - {$competitor1} total"
    assert hd(resp).groups == ["all", "score", "4.5_innings"]
    assert Enum.map(hd(resp).outcomes, & &1.id) == [13, 12]
  end
end
