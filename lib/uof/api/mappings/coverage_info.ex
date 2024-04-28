defmodule UOF.API.Mappings.CoverageInfo do
  @moduledoc false
  use Saxaboom.Mapper

  @type t :: %__MODULE__{
          level: String.t(),
          live_coverage: Boolean.t(),
          covered_from: String.t(),
          includes: list(String.t())
        }

  document do
    attribute(:level)
    attribute(:live_coverage, cast: :boolean)
    attribute(:covered_from)
    elements(:coverage, as: :includes, value: :includes)
  end
end
