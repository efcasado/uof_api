# https://docs.betradar.com/display/BD/Sport
defmodule UOF.API.Sport do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "",
            name: ""

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t
  }

  def schema do
    [
      id: ~x"./@id"s,
      name: ~x"./@name"s
    ]
  end
end
