defmodule UOF.API.Tournaments.Round do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type, :string
    field :name, :string
    field :number, :integer
    field :cup_round_matches, :integer
    field :cup_round_match_number, :integer
  end

  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, [:type, :name, :number, :cup_round_matches, :cup_round_match_number])
  end
end
