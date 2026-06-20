defmodule UOF.API.Schemas.Sports.StatisticsPeriods do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:period, UOF.API.Schemas.Sports.MatchPeriod)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:period)
  end
end
