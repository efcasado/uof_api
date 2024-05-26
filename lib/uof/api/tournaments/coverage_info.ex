defmodule UOF.API.Tournaments.CoverageInfo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :level, :string
    field :live_coverage, :boolean
    field :covered_from, :string
    # TO-DO: Inlcudes
  end

  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, [:level, :live_coverage, :covered_from])
  end
end
