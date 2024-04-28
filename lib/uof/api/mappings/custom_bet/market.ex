defmodule UOF.API.Mappings.CustomBet.Market do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.CustomBet.Outcome

  document do
    attribute(:id, cast: :integer)
    attribute(:specifiers)
    elements(:outcome, as: :outcomes, into: %Outcome{})
  end
end
