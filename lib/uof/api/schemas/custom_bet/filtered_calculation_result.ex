defmodule UOF.API.Schemas.CustomBet.FilteredCalculationResult do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:odds, :decimal)
    field(:probability, :decimal)
    field(:harmonization, :boolean)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:odds, :probability, :harmonization])
  end
end
