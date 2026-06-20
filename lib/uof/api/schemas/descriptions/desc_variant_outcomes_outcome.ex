defmodule UOF.API.Schemas.Descriptions.DescVariantOutcomesOutcome do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name])
  end
end
