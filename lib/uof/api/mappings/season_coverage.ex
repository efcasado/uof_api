defmodule UOF.API.Mappings.SeasonCoverage do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:season_id)
    attribute(:scheduled, cast: :integer)
    attribute(:played, cast: :integer)
    attribute(:max_coverage_level)
    attribute(:max_covered, cast: :integer)
    attribute(:min_coverage_level)
  end
end
