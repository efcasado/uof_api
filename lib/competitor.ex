# https://docs.betradar.com/display/BD/Competitor
defmodule UOF.API.Competitor do
  @moduledoc """
  The competitors element provides information related to the competitors taking
  part in the fixture.
  """

  import SweetXml

  defstruct id: "",
    name: "",
    state: "",
    country: "",
    abbreviation: "",
    qualifier: "",
    virtual: "",
    gender: "",
    references: []

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t,
    abbreviation: String.t,
    qualifier: String.t,
    virtual: String.t,
    gender: String.t,
    references: list(Reference.t)
  }

  def xpath_schema do
    [
      id: ~x"./@id"s,
      name: ~x"./@name"s,
      state: ~x"./@state"s,
      country: ~x"./@country"s,
      abbreviation: ~x"./@abbreviation"s,
      qualifier: ~x"./@qualifier"s,
      virtual: ~x"./@virtual"s,
      gender: ~x"./@gender"s,
      references: [
        ~x"./reference_ids/reference_id"el,
        name: ~x"./@name"s,
        value: ~x"./@value"s
      ]
    ]
  end
end
