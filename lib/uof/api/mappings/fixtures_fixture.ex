defmodule UOF.API.Mappings.FixturesFixture do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Fixture

  document do
    element(:fixture, into: %Fixture{})
  end
end
