defmodule UOF.API.Mappings.Fixture do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Competitor, CoverageInfo, ExtraInfo, ProductInfo, Reference}
  alias UOF.API.Mappings.{Season, Tournament, TournamentRound, TVChannel, Venue}

  document do
    attribute(:start_time_confirmed)
    attribute(:start_time)
    attribute(:liveodds)
    attribute(:status)
    attribute(:next_live_time)
    attribute(:id)
    attribute(:scheduled)
    attribute(:start_time_tbd)
    elements(:competitor, as: :competitors, into: %Competitor{})
    elements(:tv_channel, as: :tv_channels, into: %TVChannel{})
    elements(:reference_id, as: :references, into: %Reference{})
    element(:tournament_round, into: %TournamentRound{})
    element(:tournament, into: %Tournament{})
    element(:season, into: %Season{})
    element(:venue, into: %Venue{})
    element(:extra_info, into: %ExtraInfo{})
    element(:coverage_info, into: %CoverageInfo{})
    element(:product_info, into: %ProductInfo{})
  end
end
