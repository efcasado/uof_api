defmodule UOF.API.Schemas.Sports.Categories do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:category, UOF.API.Schemas.Sports.Category)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:category)
  end
end
