defmodule UOF.API.Mappings.SportEventStatus do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{PeriodScore, Result}

  document do
    attribute(:status)
    attribute(:match_status)
    attribute(:status_code, cast: :integer)
    attribute(:match_status_code, cast: :integer)
    attribute(:home_score, cast: :integer)
    attribute(:away_score, cast: :integer)
    attribute(:winner_id)
    elements(:period_score, as: :period_scores, into: %PeriodScore{})
    elements(:result, as: :results, into: %Result{})
  end
end
