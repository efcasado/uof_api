defmodule UOF.API.Schemas.Sports.Info do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:key, :string)
    field(:value, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:key, :value])
  end
end
