defmodule UOF.API.Mappings.SportEventStatus do
  use Saxaboom.Mapper

  document do
    attribute(:status)
    attribute(:status_code, cast: :integer)
    attribute(:match_status_code, cast: :integer)
    attribute(:home_score, cast: :integer)
    attribute(:away_score, cast: :integer)
    attribute(:winner_id)
  end
end
