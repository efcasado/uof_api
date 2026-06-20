defmodule UOF.API.Schemas.Sports.Jerseys do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:jersey, UOF.API.Schemas.Sports.Jersey)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:jersey)
  end
end
