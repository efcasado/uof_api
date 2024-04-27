defmodule UOF.API.Mappings.Summary do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{CoverageInfo, EventConditions, SportEvent, SportEventStatus}

  document do
    element(:sport_event, into: %SportEvent{})
    element(:sport_event_conditions, as: :event_conditions, into: %EventConditions{})
    element(:sport_event_status, as: :event_status, into: %SportEventStatus{})
    element(:coverage_info, into: %CoverageInfo{})
  end
end
