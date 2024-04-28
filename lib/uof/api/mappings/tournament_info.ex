defmodule UOF.API.Mappings.TournamentInfo do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{CoverageInfo, Group, Round, Season, SeasonCoverage, Tournament}

  document do
    element(:tournament, into: %Tournament{})
    element(:season, into: %Season{})
    element(:round, into: %Round{})
    element(:season_coverage, into: %SeasonCoverage{})
    element(:coverage_info, into: %CoverageInfo{})
    elements(:group, as: :groups, into: %Group{})
  end
end
