defmodule UOF.API.Schemas.Descriptions.VariantMappings do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:mapping, UOF.API.Schemas.Descriptions.VariantMappingsMapping)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:mapping)
  end
end
