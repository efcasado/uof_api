defmodule UOF.API.Schemas.Sports.CommonPeriodScore do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:type, :string)
    field(:number, :integer)
    field(:home_score, :integer)
    field(:away_score, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:type, :number, :home_score, :away_score])
  end
end
