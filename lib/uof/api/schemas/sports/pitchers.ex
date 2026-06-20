defmodule UOF.API.Schemas.Sports.Pitchers do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:pitcher, UOF.API.Schemas.Sports.Pitcher)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:pitcher)
  end
end
