defmodule UOF.API.Descriptions.Producer.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/producers.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.Producer.all/0 response" do
    resp = UOF.API.Descriptions.Producer.all()

    assert Enum.count(resp) == 15
    assert hd(resp).id == 1
    assert hd(resp).name == "LO"
    assert hd(resp).description == "Live Odds"
    assert hd(resp).api_url == "https://stgapi.betradar.com/v1/liveodds/"
    assert hd(resp).active == true
    assert hd(resp).scope == [:live]
    assert hd(resp).stateful_recovery_window_in_minutes == 600
  end
end
