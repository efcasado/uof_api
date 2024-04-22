defmodule UOF.API.Mappings.VoidReason do
  use Saxaboom.Mapper

  document do
    attribute(:id, cast: :integer)
    attribute(:description)
  end
end
