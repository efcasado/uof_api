defmodule UOF.API.Mappings.SportCategories do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Category, Sport}

  document do
    element(:sport, into: %Sport{})
    elements(:category, as: :categories, into: %Category{})
  end
end
