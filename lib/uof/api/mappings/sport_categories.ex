defmodule UOF.API.Mappings.SportCategories do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Category, Sport}

  document do
    element(:sport, into: %Sport{})
    elements(:category, as: :categories, into: %Category{})
  end
end
