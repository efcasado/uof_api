defmodule UOF.API.Sports.Sport.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/sports.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Sports.Sport.all/{0, 1} response" do
    sports = UOF.API.Sports.all()

    assert Enum.count(sports) == 204
    assert hd(sports).id == "sr:sport:143"
    assert hd(sports).name == "7BallRun"
  end
end
