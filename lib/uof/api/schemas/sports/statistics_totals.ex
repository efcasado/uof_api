defmodule UOF.API.Schemas.Sports.StatisticsTotals do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:teams, UOF.API.Schemas.Sports.StatisticsTeam)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:teams)
  end
end
