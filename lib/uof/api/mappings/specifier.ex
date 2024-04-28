defmodule UOF.API.Mappings.Specifier do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:name)
    attribute(:type)
  end
end
