defmodule UOF.API.Mappings.Probability.Cashout do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Probability.EventStatus
  alias UOF.API.Mappings.Probability.Market

  document do
    element(:sport_event_status, as: :event_status, into: %EventStatus{})
    elements(:market, as: :markets, into: %Market{})
  end
end
