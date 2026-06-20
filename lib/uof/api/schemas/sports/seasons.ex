defmodule UOF.API.Schemas.Sports.Seasons do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:season, UOF.API.Schemas.Sports.SeasonExtended)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:season)
  end
end
