# https://docs.betradar.com/display/BD/Category
defmodule UOF.API.Category do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "",
            name: "",
            country_code: ""

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t,
    country_code: String.t
  }

  def schema do
    [
      id: ~x"./@id"s,
      name: ~x"./@name"s,
      country_code: ~x"./@country_code"s
    ]
  end
end
