defmodule UOF.API.Schemas.Descriptions.VariantMappingsMapping do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:product_id, :integer)
    field(:product_ids, :string)
    field(:sport_id, :string)
    field(:market_id, :string)
    field(:sov_template, :string)
    field(:valid_for, :string)
    field(:product_market_id, :string)

    embeds_many(
      :mapping_outcome,
      UOF.API.Schemas.Descriptions.VariantMappingsMappingMappingOutcome
    )
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :product_id,
      :product_ids,
      :sport_id,
      :market_id,
      :sov_template,
      :valid_for,
      :product_market_id
    ])
    |> cast_embed(:mapping_outcome)
  end
end
