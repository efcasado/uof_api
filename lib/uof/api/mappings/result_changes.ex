defmodule UOF.API.Mappings.ResultChanges do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.ResultChange

  document do
    elements(:result_change, as: :changes, into: %ResultChange{})
  end
end
