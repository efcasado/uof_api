defmodule UOF.API.Mappings.CompetitorProfile do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Competitor, Jersey, Player, Venue}

  @type t :: %__MODULE__{
          competitor: Competitor.t(),
          venue: Venue.t(),
          jerseys: list(Jersey.t()),
          players: list(Player.t())
        }
  document do
    element(:competitor, into: %Competitor{})
    element(:venue, into: %Venue{})
    elements(:jersey, as: :jerseys, into: %Jersey{})
    elements(:player, as: :players, into: %Player{})
  end
end
