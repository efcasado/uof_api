defmodule UOF.API.Schemas.Sports.ResultScores do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:result, UOF.API.Schemas.Sports.ResultScore)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:result)
  end
end
