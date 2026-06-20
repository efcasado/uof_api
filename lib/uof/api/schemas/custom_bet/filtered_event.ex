defmodule UOF.API.Schemas.CustomBet.FilteredEvent do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    embeds_one(:markets, UOF.API.Schemas.CustomBet.FilteredMarkets)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id])
    |> cast_embed(:markets)
  end
end
