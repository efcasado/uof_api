defmodule UOF.API.Descriptions.Variant.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/variants.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Descriptions.Variant.all/0 response" do
    resp = UOF.API.Descriptions.Variant.all()

    assert Enum.count(resp) == 144
    variant = hd(resp)
    assert variant.id == "sr:correct_score:after:4"
    assert Enum.count(variant.outcomes) == 5
    outcome = hd(variant.outcomes)
    assert outcome.id == "sr:correct_score:after:4:1530"
    assert outcome.name == "4:0"
    assert Enum.count(variant.mappings) == 1
    mapping = hd(variant.mappings)
    assert mapping.product_id == 3
    assert mapping.product_ids == [3]
    assert mapping.sport_id == "sr:sport:22"
    assert mapping.market_id == 1262
    assert mapping.product_market_id == "960"
    assert Enum.count(mapping.outcome_mappings) == 5
    outcome_mapping = hd(mapping.outcome_mappings)
    assert outcome_mapping.outcome_id == "sr:correct_score:after:4:1530"
    assert outcome_mapping.product_outcome_id == 26
    assert outcome_mapping.product_outcome_name == "4:0"
  end
end
