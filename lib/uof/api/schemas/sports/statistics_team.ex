defmodule UOF.API.Schemas.Sports.StatisticsTeam do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:team, UOF.API.Schemas.Sports.TeamStatistics)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:team)
  end
end
