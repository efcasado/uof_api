defmodule UOF.API.Schemas.Sports.ExtraInfo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:info, UOF.API.Schemas.Sports.Info)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:info)
  end
end
