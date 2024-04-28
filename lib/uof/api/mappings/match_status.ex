defmodule UOF.API.Mappings.MatchStatus.Sport do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id)
  end
end

defmodule UOF.API.Mappings.MatchStatus do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id, cast: :integer)
    attribute(:description)
    attribute(:period_number, cast: :integer)
    attribute(:all, as: :all_sports, cast: :boolean, default: false)
    elements(:sport, as: :sports, into: %UOF.API.Mappings.MatchStatus.Sport{})
  end
end
