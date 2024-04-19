defmodule UOF.API.CoverageInfo do
  @moduledoc """
  """
  import SweetXml

  defstruct level: "",
            live_coverage: "",
            includes: ""

  @type t :: %__MODULE__{
    level: String.t,
    live_coverage: String.t,
    includes: String.t
  }

  def schema do
    [
      level: ~x"./@level"s,
      live_coverage: ~x"./@live_coverage"s,
      includes: ~x"./coverage/@includes"s
    ]
  end
end
