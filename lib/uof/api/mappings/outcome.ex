defmodule UOF.API.Mappings.Outcome do
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
  end
end
