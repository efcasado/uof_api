defmodule UOF.API.Mappings.Player do
  use Saxaboom.Mapper

  document do
    attribute(:type)
    attribute(:date_of_birth)
    attribute(:nationality)
    attribute(:country_code)
    attribute(:height, as: :integer)
    attribute(:weight, as: :integer)
    attribute(:full_name)
    attribute(:gender)
    attribute(:id)
    attribute(:name)
  end
end
