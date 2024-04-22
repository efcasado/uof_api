defmodule UOF.API.Mappings.Specifier do
  use Saxaboom.Mapper

  document do
    attribute(:name)
    attribute(:type)
  end
end
