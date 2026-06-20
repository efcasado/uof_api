defmodule UOF.API.Schemas.Sports.RaceDriverProfile do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one(:race_driver, UOF.API.Schemas.Sports.RaceDriver)
    embeds_one(:car, UOF.API.Schemas.Sports.Car)
    embeds_one(:race_team, UOF.API.Schemas.Sports.RaceTeam)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:race_driver)
    |> cast_embed(:car)
    |> cast_embed(:race_team)
  end
end
