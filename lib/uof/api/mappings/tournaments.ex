defmodule UOF.API.Mappings.Tournaments do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Tournament

  document do
    elements(:tournament, as: :tournaments, into: %Tournament{})
  end
end
