defmodule UOF.API.Schemas.Sports.Car do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:chassis, :string)
    field(:engine_name, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :chassis, :engine_name])
  end
end
