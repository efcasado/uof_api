defmodule UOF.API.Mappings.SportCategories do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Category

  document do
    elements(:category, as: :cateogies, into: %Category{})
  end
end
