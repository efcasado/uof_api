defmodule UOF.API.Mappings.Tournaments do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Tournament

  document do
    elements(:tournament, as: :tournaments, into: %Tournament{})
  end
end
