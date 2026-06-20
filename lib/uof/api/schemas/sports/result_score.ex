defmodule UOF.API.Schemas.Sports.ResultScore do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:home_score, :string)
    field(:away_score, :string)
    field(:match_status_code, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:home_score, :away_score, :match_status_code])
  end
end
