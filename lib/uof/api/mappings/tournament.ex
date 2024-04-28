defmodule UOF.API.Mappings.Tournament do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Category, CurrentSeason, SeasonCoverage, Sport}

  document do
    attribute(:id)
    attribute(:name)
    element(:current_season, into: %CurrentSeason{})
    element(:season_coverage_info, as: :season_coverage, into: %SeasonCoverage{})
    element(:sport, into: %Sport{})
    element(:category, into: %Category{})
  end
end
