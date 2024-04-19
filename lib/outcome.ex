defmodule UOF.API.Outcome do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "",
    name: ""

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t
  }

  def new(fields) do
    struct(fields, __MODULE__)
  end

  def schema do
    [
      id: ~x"./@id"i,
      name: ~x"./@name"s
    ]
  end
end
