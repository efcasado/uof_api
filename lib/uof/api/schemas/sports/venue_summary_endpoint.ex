defmodule UOF.API.Schemas.Sports.VenueSummaryEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:venue, UOF.API.Schemas.Sports.Venue)
    embeds_one(:home_teams, UOF.API.Schemas.Sports.HomeTeams)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:venue)
    |> cast_embed(:home_teams)
  end
end
