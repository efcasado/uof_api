defmodule UOF.API.Schemas.Probability.Results do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:result, UOF.API.Schemas.Probability.Result)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:result)
  end
end
