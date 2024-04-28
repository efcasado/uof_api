defmodule UOF.API.Mappings.Reference do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:name)
    attribute(:value)
  end
end
