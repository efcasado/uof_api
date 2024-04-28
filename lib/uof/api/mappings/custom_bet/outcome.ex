defmodule UOF.API.Mappings.CustomBet.Outcome do
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:conflict, cast: :boolean)
  end
end
