defmodule UOF.API.Descriptions.MatchStatus.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/match_status.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.MatchStatus/0 response" do
    resp = UOF.API.Descriptions.MatchStatus.all()

    assert Enum.count(resp) == 185

    assert Enum.at(resp, 0).id == 0
    assert Enum.at(resp, 0).description == "Not started"
    assert Enum.at(resp, 0).period_number == nil
    assert Enum.at(resp, 0).sports.all == true
    assert Enum.at(resp, 0).sports.ids == []

    assert Enum.at(resp, 1).id == 1
    assert Enum.at(resp, 1).description == "1st period"
    assert Enum.at(resp, 1).period_number == 1
    assert Enum.at(resp, 1).sports.all == false

    assert Enum.at(resp, 1).sports.ids ==
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
end
