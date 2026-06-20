defmodule UOF.API.Schemas.Descriptions.Mappings do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:mapping, UOF.API.Schemas.Descriptions.MappingsMapping)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:mapping)
  end
end
