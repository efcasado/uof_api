defmodule UOF.API.Schemas.Sports.ProductInfoItem do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
  end
end
