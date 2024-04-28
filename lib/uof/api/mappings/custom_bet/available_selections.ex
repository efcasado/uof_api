defmodule UOF.API.Mappings.CustomBet.AvailableSelections do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.CustomBet.Market

  document do
    attribute(:generated_at)
    element(:event, as: :event_id, value: :id)
    elements(:market, as: :markets, into: %Market{})
  end
end
