defmodule UOF.API.Descriptions.VoidReason.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/void_reasons.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.VoidReason.all/0 response" do
    resp = UOF.API.Descriptions.VoidReason.all()

    assert Enum.count(resp) == 17
    assert hd(resp).id == 0
    assert hd(resp).description == :OTHER
  end
end
