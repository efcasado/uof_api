defmodule UOF.API.Schemas.Sports.SeasonCoverageInfo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:season_id, :string)
    field(:scheduled, :integer)
    field(:played, :integer)
    field(:max_coverage_level, :string)
    field(:max_covered, :integer)
    field(:min_coverage_level, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :season_id,
      :scheduled,
      :played,
      :max_coverage_level,
      :max_covered,
      :min_coverage_level
    ])
  end
end
