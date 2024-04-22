defmodule UOF.API.Mappings.Summary do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{CoverageInfo, SportEvent, SportEventStatus}

  document do
    element(:sport_event, into: %SportEvent{})
    # element :sport_event_conditions, into: %UOF.API.SportEventConditions{}
    element(:sport_event_status, into: %SportEventStatus{})
    element(:coverage_info, into: %CoverageInfo{})
  end
end
