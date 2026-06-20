defmodule UOF.API.Schemas.Sports.FixtureChangesEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_many(:fixture_change, UOF.API.Schemas.Sports.FixtureChange)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:fixture_change)
  end
end
