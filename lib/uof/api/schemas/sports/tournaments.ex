defmodule UOF.API.Schemas.Sports.Tournaments do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:tournament, UOF.API.Schemas.Sports.Tournament)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:tournament)
  end
end
