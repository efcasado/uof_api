defmodule UOF.API.Mappings.Venue do
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
    attribute(:capacity, cast: :integer)
    attribute(:city_name)
    attribute(:country_name)
    attribute(:map_coordinates)
    attribute(:country_code)
  end
end
