defmodule UOF.API.Schemas.Sports.SportTournamentsEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:sport, UOF.API.Schemas.Sports.Sport)
    embeds_one(:tournaments, UOF.API.Schemas.Sports.Tournaments)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:sport)
    |> cast_embed(:tournaments)
  end
end
