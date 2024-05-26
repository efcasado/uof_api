defmodule UOF.API.Descriptions.BettingStatus.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/betting_status.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.BettingStatus.all/0 response" do
    resp = UOF.API.Descriptions.BettingStatus.all()

    assert Enum.count(resp) == 7
    assert hd(resp).id == 0
    assert hd(resp).description == :UNKNOWN
  end
end
