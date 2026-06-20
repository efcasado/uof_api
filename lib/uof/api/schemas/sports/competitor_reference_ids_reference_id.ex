defmodule UOF.API.Schemas.Sports.CompetitorReferenceIdsReferenceId do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:value, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :value])
  end
end
