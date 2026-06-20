defmodule UOF.API.Schemas.Sports.Timeline do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:event, UOF.API.Schemas.Sports.BasicEvent)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:event)
  end
end
