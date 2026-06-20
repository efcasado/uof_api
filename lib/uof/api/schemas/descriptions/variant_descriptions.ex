defmodule UOF.API.Schemas.Descriptions.VariantDescriptions do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    embeds_many(:variant, UOF.API.Schemas.Descriptions.DescVariant)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code])
    |> cast_embed(:variant)
  end
end
