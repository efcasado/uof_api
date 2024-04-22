defmodule UOF.API.Mappings.Category do
  use Saxaboom.Mapper

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          country_code: String.t()
        }

  document do
    attribute(:id)
    attribute(:name)
    attribute(:country_code)
  end
end
