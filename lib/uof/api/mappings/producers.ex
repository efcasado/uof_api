defmodule UOF.API.Mappings.Producers do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Producer

  document do
    elements(:producer, as: :producers, into: %Producer{})
  end
end
