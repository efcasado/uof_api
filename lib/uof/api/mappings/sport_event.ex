defmodule UOF.API.Mappings.SportEvent do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Competitor, Tournament}

  document do
    attribute(:liveodds)
    attribute(:status)
    attribute(:next_live_time)
    attribute(:id)
    attribute(:scheduled)
    attribute(:start_time_tbd, cast: :boolean)
    element(:tournament, into: %Tournament{})
    elements(:competitor, as: :competitors, into: %Competitor{})
  end
end
