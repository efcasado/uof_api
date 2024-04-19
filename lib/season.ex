# https://docs.betradar.com/display/BD/Season
defmodule UOF.API.Season do
  @moduledoc """
  """
  import SweetXml

  defstruct id: "",
            name: "",
            start_date: "",
            end_date: "",
            year: "",
            tournament_id: ""

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t,
    start_date: String.t,
    end_date: String.t,
    year: String.t,
    tournament_id: String.t
  }

  def schema do
    [
      id: ~x"./@id"s,
      name: ~x"./@name"s,
      start_date: ~x"./@start_date"s,
      end_date: ~x"./@end_date"s,
      year: ~x"./@year"s,
      tournament_id: ~x"./@tournament_id"s
    ]
  end
end
