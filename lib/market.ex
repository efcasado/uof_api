defmodule UOF.API.Market do
  @moduledoc """
  """
  alias UOF.API.Outcome
  alias UOF.API.Specifier
  import SweetXml

  defstruct id: 0,
    name: "",
    groups: "",
    outcomes: [],
    specifiers: []


  @type t :: %__MODULE__{
    id: non_neg_integer,
    name: String.t,
    groups: String.t,
    outcomes: list(Outcome),
    specifiers: list(Specifier)
  }

  def schema do
    [
      id: ~x"./@id"i,
      name: ~x"./@name"s,
      groups: ~x"./@groups"s,
      outcomes: [~x"//outcome"el| Outcome.schema],
      specifiers: [~x"//specifier"el| Specifier.schema]
    ]
  end
end
