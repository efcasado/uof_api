defmodule UOF.API.Mappings.TournamentRound do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:betradar_id, cast: :integer)
    attribute(:betradar_name)
    attribute(:type)
    # cup
    attribute(:name)
    attribute(:cup_round_matches, cast: :integer)
    attribute(:cup_round_match_number, cast: :integer)
    attribute(:other_match_id)
    # group
    attribute(:number)
    attribute(:group)
    attribute(:group_id)
    attribute(:group_long_name)
    # qualification
    # ???
    attribute(:phase)
  end
end
