defmodule UOF.API.Schemas.Descriptions.VariantMappingsMappingMappingOutcome do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:outcome_id, :string)
    field(:product_outcome_id, :string)
    field(:product_outcome_name, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:outcome_id, :product_outcome_id, :product_outcome_name])
  end
end
