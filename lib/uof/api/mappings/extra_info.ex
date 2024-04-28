defmodule UOF.API.Mappings.ExtraInfo do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:key)
    attribute(:value)
  end
end
