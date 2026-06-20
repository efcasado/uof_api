defmodule UOF.API.Schemas.Descriptions.DescSpecifiers do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:specifier, UOF.API.Schemas.Descriptions.DescSpecifiersSpecifier)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:specifier)
  end
end
