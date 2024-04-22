defmodule UOF.API.Mappings.MatchStatus.Sport do
  use Saxaboom.Mapper

  document do
    attribute(:id)
  end
end

defmodule UOF.API.Mappings.MatchStatus do
  use Saxaboom.Mapper

  document do
    attribute(:id, cast: :integer)
    attribute(:description)
    elements(:sport, as: :sport, into: %UOF.API.Mappings.MatchStatus.Sport{})
  end
end
