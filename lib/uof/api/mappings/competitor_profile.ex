defmodule UOF.API.Mappings.CompetitorProfile do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Competitor, Jersey, Manager, Player, Venue}

  @type t :: %__MODULE__{
          competitor: Competitor.t(),
          venue: Venue.t(),
          jerseys: list(Jersey.t()),
          players: list(Player.t())
        }
  document do
    element(:competitor, into: %Competitor{})
    element(:venue, into: %Venue{})
    element(:manager, into: %Manager{})
    elements(:jersey, as: :jerseys, into: %Jersey{})
    elements(:player, as: :players, into: %Player{})
  end
end
