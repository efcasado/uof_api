defmodule UOF.API.Mappings.Sport do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
  end
end
