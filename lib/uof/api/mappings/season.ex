defmodule UOF.API.Mappings.Season do
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
    attribute(:start_date)
    attribute(:end_date)
    attribute(:year)
    attribute(:tournament_id)
  end
end
