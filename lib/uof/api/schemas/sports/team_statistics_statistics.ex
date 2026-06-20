defmodule UOF.API.Schemas.Sports.TeamStatisticsStatistics do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:cards, :string)
    field(:corner_kicks, :string)
    field(:yellow_cards, :string)
    field(:yellow_red_cards, :string)
    field(:red_cards, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:cards, :corner_kicks, :yellow_cards, :yellow_red_cards, :red_cards])
  end
end
