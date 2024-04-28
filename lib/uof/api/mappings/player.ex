defmodule UOF.API.Mappings.Player do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:type)
    attribute(:date_of_birth)
    attribute(:nationality)
    attribute(:country_code)
    attribute(:height, cast: :integer)
    attribute(:weight, cast: :integer)
    attribute(:jersey_number, cast: :integer)
    attribute(:full_name)
    attribute(:gender)
    attribute(:id)
    attribute(:name)
  end
end
