defmodule UOF.API.Users.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/whoami.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Users.whoami/0 response" do
    {:ok, details} = UOF.API.Users.whoami()

    assert details.expire_at == "2023-02-03T22:50:17Z"
    assert details.bookmaker_id == "11111"
    assert details.virtual_host == "/unifiedfeed/11111"
  end
end
