defmodule UOF.API.Mappings.PlayerProfile do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Player

  document do
    element(:player, into: %Player{})
  end
end
