defmodule UOF.API.Mappings.Competitor do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{Category, Reference, Sport}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          state: String.t(),
          country: String.t(),
          qualifier: String.t(),
          virtual: String.t(),
          gender: String.t(),
          sport: Sport.t(),
          category: Category.t(),
          references: list(Reference.t())
        }

  document do
    attribute(:id)
    attribute(:name)
    attribute(:state)
    attribute(:country)
    attribute(:abbreviation)
    attribute(:qualifier)
    attribute(:virtual)
    attribute(:gender)
    element(:sport, into: %Sport{})
    element(:category, into: %Category{})
    elements(:reference_id, as: :references, into: %Reference{})
  end
end
