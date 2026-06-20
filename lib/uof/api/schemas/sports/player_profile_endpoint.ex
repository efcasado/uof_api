defmodule UOF.API.Schemas.Sports.PlayerProfileEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:player, UOF.API.Schemas.Sports.PlayerExtended)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:player)
  end
end
