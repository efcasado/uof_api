defmodule UOF.API.Mappings.OutcomeMapping do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:outcome_id)
    attribute(:product_outcome_id)
    attribute(:product_outcome_name)
  end
end
