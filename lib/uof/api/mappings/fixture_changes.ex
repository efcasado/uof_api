defmodule UOF.API.Mappings.FixtureChanges do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.FixtureChange

  document do
    elements(:fixture_change, as: :changes, into: %FixtureChange{})
  end
end
