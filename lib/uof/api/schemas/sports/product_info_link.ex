defmodule UOF.API.Schemas.Sports.ProductInfoLink do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:ref, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :ref])
  end
end
