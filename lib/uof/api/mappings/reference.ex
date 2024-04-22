defmodule UOF.API.Mappings.Reference do
  use Saxaboom.Mapper

  document do
    attribute(:name)
    attribute(:value)
  end
end
