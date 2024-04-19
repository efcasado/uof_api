defmodule UOF.API.VoidReason do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "", description: ""

  @type t :: %__MODULE__{
    id: String.t,
    description: String.t
  }

  def schema do
    [
      id: ~x"./@id"i,
      description: ~x"./@description"s
    ]
  end
end
