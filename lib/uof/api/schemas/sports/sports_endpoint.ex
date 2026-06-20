defmodule UOF.API.Schemas.Sports.SportsEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_many(:sport, UOF.API.Schemas.Sports.Sport)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:sport)
  end
end
