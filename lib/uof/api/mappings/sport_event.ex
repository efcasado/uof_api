defmodule UOF.API.Mappings.SportEvent do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Competitor, Season, Tournament, TournamentRound, Venue}

  document do
    attribute(:liveodds)
    attribute(:status)
    attribute(:next_live_time)
    attribute(:id)
    attribute(:scheduled)
    attribute(:start_time_tbd, cast: :boolean)
    element(:venue, into: %Venue{})
    element(:season, into: %Season{})
    element(:tournament_round, into: %TournamentRound{})
    element(:tournament, into: %Tournament{})
    elements(:competitor, as: :competitors, into: %Competitor{})
  end
end
