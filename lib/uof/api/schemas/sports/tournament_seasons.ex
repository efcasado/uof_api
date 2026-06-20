defmodule UOF.API.Schemas.Sports.TournamentSeasons do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:tournament, UOF.API.Schemas.Sports.Tournament)
    embeds_one(:seasons, UOF.API.Schemas.Sports.Seasons)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:tournament)
    |> cast_embed(:seasons)
  end
end
