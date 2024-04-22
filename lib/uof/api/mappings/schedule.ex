defmodule UOF.API.Mappings.Schedule do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.SportEvent

  document do
    elements(:sport_event, as: :events, into: %SportEvent{})
  end
end
