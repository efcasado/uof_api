defmodule UOF.API.Mappings.Manager do
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
    attribute(:nationality)
    attribute(:country_code)
  end
end
