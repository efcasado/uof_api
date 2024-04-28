defmodule UOF.API.Mappings.CustomBet.Calculation do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.CustomBet.AvailableSelections

  document do
    attribute(:generated_at)
    attribute(:odds, cast: :float)
    attribute(:probability, cast: :float)
    element(:available_selections, into: %AvailableSelections{})
  end
end
