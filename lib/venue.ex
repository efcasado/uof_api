# https://docs.betradar.com/display/BD/Venue
defmodule UOF.API.Venue do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "",
            name: "",
            city_name: "",
            country_name: "",
            country_code: "",
            capacity: 0,
            map_coordinates: ""

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t,
    city_name: String.t,
    country_name: String.t,
    country_code: String.t,
    capacity: non_neg_integer,
    map_coordinates: String.t
  }

  def schema do
    [
      id: ~x"./@id"s,
      name: ~x"./@name"s,
      capacity: ~x"./@capacity"oi,
      city_name: ~x"./@city_name"s,
      country_name: ~x"./@country_name"s,
      map_coordinates: ~x"./@map_coordinates"s,
      country_code: ~x"./@country_code"s
    ]
  end
end
