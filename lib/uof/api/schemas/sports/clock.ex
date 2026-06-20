defmodule UOF.API.Schemas.Sports.Clock do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:match_time, :string)
    field(:stoppage_time, :string)
    field(:stoppage_time_announced, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:match_time, :stoppage_time, :stoppage_time_announced])
  end
end
