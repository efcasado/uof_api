defmodule UOF.API.Schemas.Probability.Periodscores do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:period_score, UOF.API.Schemas.Probability.PeriodScore)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:period_score)
  end
end
