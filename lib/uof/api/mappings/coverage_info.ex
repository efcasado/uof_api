defmodule UOF.API.Mappings.CoverageInfo do
  use Saxaboom.Mapper

  @type t :: %__MODULE__{
          level: String.t(),
          live_coverage: String.t(),
          includes: String.t()
        }

  document do
    attribute(:level)
    attribute(:live_coverage)
    # <coverage_info ...><coverage includes="..."/></coverage_info>
    attribute(:includes)
  end
end
