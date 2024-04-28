defmodule UOF.API.Users.Test do
  use ExUnit.Case
  import Mock

  # mock http requests towards Betradar and use recorded responses instead
  setup_with_mocks([
    {UOF.API.Utils.HTTP, [:passthrough],
     [
       get: fn schema, endpoint ->
         data = File.read!("test/data/" <> Enum.at(endpoint, -1))
         Saxaboom.parse(data, schema)
       end
     ]}
  ]) do
    :ok
  end

  test "can parse UOF.API.Users.whoami/0 response" do
    {:ok, details} = UOF.API.Users.whoami()

    assert details.expire_at == "2023-02-03T22:50:17Z"
    assert details.bookmaker_id == "11111"
    assert details.virtual_host == "/unifiedfeed/11111"
  end
end
