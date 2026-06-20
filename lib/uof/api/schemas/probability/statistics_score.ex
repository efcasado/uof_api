defmodule UOF.API.Schemas.Probability.StatisticsScore do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:home, :integer)
    field(:away, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:home, :away])
  end
end
