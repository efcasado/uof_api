defmodule UOF.API.Mappings.VenueProfile do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Competitor, Venue}

  document do
    element(:venue, into: %Venue{})
    elements(:competitor, as: :home_teams, into: %Competitor{})
  end
end
