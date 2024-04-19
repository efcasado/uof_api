defmodule UOF.API.MatchStatus do
  @moduledoc """
  """
  alias UOF.API.Sport
  import SweetXml

  defstruct id: "", description: "", sports: []

  @type t :: %__MODULE__{
    id: String.t,
    description: String.t,
    sports: list(Sport.t)
  }

  def schema do
    [
      id: ~x"./@id"i,
      description: ~x"./@description"s,
      sports: [~x"//match_status/sports/sport"el| Sport.schema]
    ]
  end
end
