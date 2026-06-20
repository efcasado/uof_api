defmodule UOF.API.Schemas.Descriptions.Attributes do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:attribute, UOF.API.Schemas.Descriptions.AttributesAttribute)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:attribute)
  end
end
