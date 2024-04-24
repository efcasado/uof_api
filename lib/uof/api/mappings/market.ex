defmodule UOF.API.Mappings.Market do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Outcome, Specifier}

  document do
    attribute(:id, cast: :integer)
    attribute(:name)
    attribute(:groups)
    # attribute :outcome_type, as: :market.outcome_type
    elements(:outcome, as: :outcomes, into: %Outcome{})
    elements(:specifier, as: :specifiers, into: %Specifier{})
  end
end
