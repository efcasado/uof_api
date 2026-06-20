defmodule UOF.API.Schemas.Sports.PeriodScores do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:period_score, UOF.API.Schemas.Sports.CommonPeriodScore)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:period_score)
  end
end
