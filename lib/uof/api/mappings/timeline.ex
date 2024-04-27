defmodule UOF.API.Mappings.Timeline do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{
    CoverageInfo,
    EventConditions,
    SportEvent,
    SportEventStatus,
    TimelineEvent
  }

  document do
    element(:sport_event, into: %SportEvent{})
    element(:sport_event_conditions, as: :event_conditions, into: %EventConditions{})
    element(:sport_event_status, as: :event_status, into: %SportEventStatus{})
    element(:coverage_info, into: %CoverageInfo{})
    elements(:event, as: :events, into: %TimelineEvent{})
    # elements(:event, as: :timeline, with: [type: "match_started"], into: %MatchStarted{})
    # elements(:event, as: :timeline, with: [type: "period_start"], into: %PeriodStarted{})
    # elements(:event, as: :timeline, with: [type: "score_change"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "score_change"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "yellow_card"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "red_card"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "period_score"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "break_start"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "period_start"], into: %ScoreChanged{})
    # elements(:event, as: :timeline, with: [type: "match_ended"], into: %ScoreChanged{})
  end
end
