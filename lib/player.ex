# https://docs.betradar.com/display/BD/Player
defmodule UOF.API.Player do
  @moduledoc """
  """
  import SweetXml

  defstruct type: "",
            date_of_birth: "",
            nationality: "",
            country_code: "",
            height: 0,
            weight: 0,
            full_name: "",
            gender: "",
            id: "",
            name: ""

  @type t :: %__MODULE__{
    type: String.t,
    date_of_birth: String.t,
    nationality: String.t,
    country_code: String.t,
    height: non_neg_integer,
    weight: non_neg_integer,
    full_name: String.t,
    gender: String.t,
    id: String.t,
    name: String.t
  }

  def schema do
    [
      type: ~x"./@type"s,
      date_of_birth: ~x"./@date_of_birth"s,
      nationality: ~x"./@nationality"s,
      country_code: ~x"./@country_code"s,
      height: ~x"./@height"oi,
      weight: ~x"./@weight"oi,
      full_name: ~x"./@full_name"s,
      gender: ~x"./@gender"s,
      id: ~x"./@id"s,
      name: ~x"./@name"s
    ]
  end
end
