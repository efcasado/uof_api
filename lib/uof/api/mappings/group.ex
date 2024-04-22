defmodule UOF.API.Mappings.Group do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Competitor

  document do
    attribute(:id)
    attribute(:name)
    elements(:competitor, as: :competitors, into: %Competitor{})
  end
end
