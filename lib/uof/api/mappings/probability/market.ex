defmodule UOF.API.Mappings.Probability.Market do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Probability.Outcome

  document do
    attribute(:id, cast: :integer)
    attribute(:status, cast: :integer)
    attribute(:cashout_status, cast: :integer)
    attribute(:specifiers)
    elements(:outcome, as: :outcomes, into: %Outcome{})
  end
end
