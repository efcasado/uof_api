defmodule UOF.API.Mappings.Round do
  use Saxaboom.Mapper

  document do
    attribute(:type)
    attribute(:name)
    attribute(:cup_round_matches, cast: :integer)
    attribute(:cup_round_match_number, cast: :integer)
  end
end
