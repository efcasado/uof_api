# https://docs.betradar.com/display/BD/Tournament
defmodule UOF.API.Tournament do
  @moduledoc """
  """
  alias UOF.API.Category
  alias UOF.API.Competitor
  alias UOF.API.Season
  alias UOF.API.Sport
  import SweetXml

  defstruct id: "",
    name: "",
    current_season: %Season{},
    sport: %Sport{},
    category: %Category{},
    competitors: []

  @type t :: %__MODULE__{
    id: String.t,
    name: String.t,
    current_season: Season.t,
    sport: Sport.t,
    category: Category.t,
    competitors: list(Competitor.t)
  }

  def schema do
    [
      # TO-DO: do not re-use @season for @current_seasson (eg. similar but wo/ tournament_id)
      id: ~x"./@id"s,
      name: ~x"./@name"s,
      current_season: [~x"./current_season"o | Season.schema],
      sport: [~x"./sport" | Sport.schema],
      category: [~x"./category" | Category.schema],
      competitors: [~x"./competitors/competitor"el | Competitor.schema]
    ]
  end
end
