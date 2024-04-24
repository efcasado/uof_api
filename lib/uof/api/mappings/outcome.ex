defmodule UOF.API.Mappings.Outcome do
  use Saxaboom.Mapper

  document do
    attribute(:id, cast: :integer)
    attribute(:name)
  end
end
