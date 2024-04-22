defmodule UOF.API.Mappings.TournamentInfo do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{CoverageInfo, Group, Season, SeasonCoverage, Tournament}

  document do
    element(:tournament, into: %Tournament{})
    element(:season, into: %Season{})
    element(:season_coverage, into: %SeasonCoverage{})
    element(:coverage_info, into: %CoverageInfo{})
    elements(:group, as: :groups, into: %Group{})
  end
end
