defmodule UOF.API.Schemas.Probability.Result do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:match_status_code, :integer)
    field(:home_score, :decimal)
    field(:away_score, :decimal)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:match_status_code, :home_score, :away_score])
  end
end
