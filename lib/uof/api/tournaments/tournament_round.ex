defmodule UOF.API.Tournaments.TournamentRound do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :betradar_id, :integer
    field :betradar_name
    field :type, :string
    # cup
    field :name, :string
    field :cup_round_matches, :integer
    field :cup_round_match_number, :integer
    field :other_match_id
    # group
    field :number
    field :group
    field :group_id
    field :group_long_name
    # qualification
    # ???
    field :phase
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :betradar_id,
      :betradar_name,
      :type,
      :name,
      :number,
      :cup_round_matches,
      :cup_round_match_number,
      :other_match_id,
      :group,
      :group_id,
      :group_long_name,
      :phase
    ])
  end
end
