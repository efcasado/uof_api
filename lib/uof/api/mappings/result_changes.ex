defmodule UOF.API.Mappings.ResultChanges do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.ResultChange

  document do
    elements(:result_change, as: :changes, into: %ResultChange{})
  end
end
