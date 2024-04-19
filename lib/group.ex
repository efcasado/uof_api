defmodule UOF.API.Group do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "", name: "", competitors: []

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t,
    competitors: list(Competitor.t)
  }

  def schema do
    [
      id: ~x"./@id"s,
      name: ~x"./@name"s,
      competitors: [~x"./competitor"el | @competitor]
    ]
  end
end
