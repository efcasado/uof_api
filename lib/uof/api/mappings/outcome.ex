defmodule UOF.API.Mappings.Outcome do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
  end
end
