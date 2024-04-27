defmodule UOF.API.Mappings.PeriodScore do
  use Saxaboom.Mapper

  document do
    attribute(:home_score, cast: :integer)
    attribute(:away_score, cast: :integer)
    attribute(:match_status_code, cast: :integer)
    attribute(:type)
    attribute(:number, cast: :integer)
  end
end
