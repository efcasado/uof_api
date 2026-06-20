defmodule UOF.API.Schemas.Sports.MatchRound do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:type, :string)
    field(:number, :integer)
    field(:name, :string)
    field(:group_long_name, :string)
    field(:group, :string)
    field(:group_id, :string)
    field(:cup_round_matches, :integer)
    field(:cup_round_match_number, :integer)
    field(:other_match_id, :string)
    field(:betradar_id, :integer)
    field(:betradar_name, :string)
    field(:phase, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :type,
      :number,
      :name,
      :group_long_name,
      :group,
      :group_id,
      :cup_round_matches,
      :cup_round_match_number,
      :other_match_id,
      :betradar_id,
      :betradar_name,
      :phase
    ])
  end
end
