defmodule UOF.API.Mappings.EventConditions do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Venue

  document do
    attribute(:attendance, cast: :integer)
    element(:venue, into: %Venue{})
  end
end
