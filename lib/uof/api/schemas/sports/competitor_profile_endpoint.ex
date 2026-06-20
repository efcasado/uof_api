defmodule UOF.API.Schemas.Sports.CompetitorProfileEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:competitor, UOF.API.Schemas.Sports.TeamExtended)
    embeds_one(:venue, UOF.API.Schemas.Sports.Venue)
    embeds_one(:jerseys, UOF.API.Schemas.Sports.Jerseys)
    embeds_one(:manager, UOF.API.Schemas.Sports.Manager)
    embeds_one(:players, UOF.API.Schemas.Sports.Players)
    embeds_one(:race_driver_profile, UOF.API.Schemas.Sports.RaceDriverProfile)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:competitor)
    |> cast_embed(:venue)
    |> cast_embed(:jerseys)
    |> cast_embed(:manager)
    |> cast_embed(:players)
    |> cast_embed(:race_driver_profile)
  end
end
