defmodule UOF.API.Mappings.Sports do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Sport

  document do
    elements(:sport, as: :sports, into: %Sport{})
  end
end
