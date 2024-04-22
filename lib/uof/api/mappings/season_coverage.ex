defmodule UOF.API.Mappings.SeasonCoverage do
  use Saxaboom.Mapper

  document do
    attribute(:season_id)
    attribute(:scheduled)
    attribute(:played)
    attribute(:max_coverage_level)
    attribute(:max_covered)
    attribute(:min_coverage_level)
  end
end
