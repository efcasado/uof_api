defmodule UOF.API.Schemas.Sports.TournamentGroups do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:group, UOF.API.Schemas.Sports.TournamentGroup)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:group)
  end
end
