defmodule UOF.API.Mappings.Tournament do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Category, CurrentSeason, Sport}

  document do
    attribute(:id)
    attribute(:name)
    element(:current_season, into: %CurrentSeason{})
    element(:sport, into: %Sport{})
    element(:category, into: %Category{})
  end
end
