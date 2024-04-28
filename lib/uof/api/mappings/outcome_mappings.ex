defmodule UOF.API.Mappings.OutcomeMappings do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.OutcomeMapping

  document do
    attribute(:product_id, cast: :integer)
    attribute(:product_ids)
    attribute(:sport_id)
    attribute(:market_id, cast: :integer)
    attribute(:product_market_id)
    elements(:mapping_outcome, as: :outcome_mappings, into: %OutcomeMapping{})
  end
end
