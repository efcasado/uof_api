defmodule UOF.API.Schemas.CustomBet.FilteredCalculationResponse do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:calculation, UOF.API.Schemas.CustomBet.FilteredCalculationResult)

    embeds_one(
      :available_selections,
      UOF.API.Schemas.CustomBet.AvailableSelectionsFilteredOutcomes
    )
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:calculation)
    |> cast_embed(:available_selections)
  end
end
