defmodule UOF.API.Schemas.Sports.Competitors do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:competitor, UOF.API.Schemas.Sports.Team)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:competitor)
  end
end
