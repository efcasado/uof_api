defmodule UOF.API.Mappings.ExtraInfo do
  use Saxaboom.Mapper

  document do
    attribute(:key)
    attribute(:value)
  end
end
