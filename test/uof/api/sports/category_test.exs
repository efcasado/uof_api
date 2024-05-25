defmodule UOF.API.Sports.Category.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/categories.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Sports.categories/{1, 2} response" do
    categories = UOF.API.Sports.categories("sr:sport:1")

    category = hd(categories)
    assert Enum.count(categories) == 224
    assert category.id == "sr:category:1"
    assert category.name == "England"
    assert category.country_code == "ENG"
  end
end
