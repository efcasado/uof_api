defmodule UOF.API.Schemas.Probability.PeriodScore do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:match_status_code, :integer)
    field(:number, :integer)
    field(:home_score, :decimal)
    field(:away_score, :decimal)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:match_status_code, :number, :home_score, :away_score])
  end
end
