# https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
defmodule UOF.API.SeasonCoverage do
  @moduledoc """
  """
  import SweetXml

  defstruct season_id: "",
            scheduled: 0,
            played: 0,
            max_covered: 0,
            max_coverage_level: "",
            min_coverage_level: ""

  @type t :: %__MODULE__{
    season_id: String.t,
    scheduled: non_neg_integer,
    played: non_neg_integer,
    max_covered: non_neg_integer,
    max_coverage_level: String.t,
    min_coverage_level: String.t
  }

  def schema do
    [
      scheduled: ~x"./@scheduled"i,
      season_id: ~x"./@season_id"s,
      played: ~x"./@played"i,
      min_coverage_level: ~x"./@min_coverage_level"s,
      max_covered: ~x"./@max_covered"i,
      max_coverage_level: ~x"./@max_coverage_level"s
    ]
  end
end
