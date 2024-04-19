defmodule UOF.API.Specifier do
  @moduledoc """
  """
  import SweetXml

  defstruct name: "",
    type: ""

  @type t :: %__MODULE__{
    name: String.t,
    type: String.t
  }

  def schema do
    [
      name: ~x"./@name"s,
      type: ~x"./@type"s
    ]
  end
end
