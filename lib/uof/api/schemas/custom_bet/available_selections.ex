defmodule UOF.API.Schemas.CustomBet.AvailableSelections do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:event, UOF.API.Schemas.CustomBet.Event)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:event)
  end
end
