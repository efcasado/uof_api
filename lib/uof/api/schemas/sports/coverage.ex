defmodule UOF.API.Schemas.Sports.Coverage do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:includes, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:includes])
  end
end
