defmodule UOF.API.Schemas.Sports.Pitcher do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:hand, :string)
    field(:competitor, :string)
    field(:id, :string)
    field(:short_name, :string)
    field(:changed_at, :utc_datetime)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :hand, :competitor, :id, :short_name, :changed_at])
  end
end
