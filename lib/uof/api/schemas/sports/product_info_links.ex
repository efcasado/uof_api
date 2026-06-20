defmodule UOF.API.Schemas.Sports.ProductInfoLinks do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:link, UOF.API.Schemas.Sports.ProductInfoLink)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:link)
  end
end
