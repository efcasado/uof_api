defmodule UOF.API.Schemas.Sports.Players do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:player, UOF.API.Schemas.Sports.PlayerExtended)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:player)
  end
end
