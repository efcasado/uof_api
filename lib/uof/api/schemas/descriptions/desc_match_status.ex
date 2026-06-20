defmodule UOF.API.Schemas.Descriptions.DescMatchStatus do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:description, :string)
    field(:period_number, :integer)
    embeds_one(:sports, UOF.API.Schemas.Descriptions.DescMatchStatusSports)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :description, :period_number])
    |> cast_embed(:sports)
  end
end
