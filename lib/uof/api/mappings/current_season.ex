defmodule UOF.API.Mappings.CurrentSeason do
  @moduledoc false
  use Saxaboom.Mapper

  @type t :: %__MODULE__{
          start_date: String.t(),
          end_date: String.t(),
          year: String.t(),
          id: String.t(),
          name: String.t()
        }
  document do
    attribute(:start_date)
    attribute(:end_date)
    attribute(:year)
    attribute(:id)
    attribute(:name)
  end
end
