defmodule UOF.API.Schemas.Sports.Course do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    embeds_many(:hole, UOF.API.Schemas.Sports.Hole)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name])
    |> cast_embed(:hole)
  end
end
