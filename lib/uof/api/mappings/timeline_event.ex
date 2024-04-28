defmodule UOF.API.Mappings.TimelineEvent.GoalScorer do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
  end
end

defmodule UOF.API.Mappings.TimelineEvent.Assist do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:type)
    attribute(:id)
    attribute(:name)
  end
end

defmodule UOF.API.Mappings.TimelineEvent.Player do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:name)
  end
end

defmodule UOF.API.Mappings.TimelineEvent do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.TimelineEvent.{Assist, GoalScorer, Player}

  document do
    attribute(:id)
    attribute(:type)
    attribute(:time)
    attribute(:match_status_code, cast: :integer)
    attribute(:match_time)
    attribute(:match_clock)
    attribute(:team)
    attribute(:x)
    attribute(:y)
    attribute(:home_score, cast: :integer)
    attribute(:away_score, cast: :integer)
    attribute(:period, cast: :integer)
    attribute(:period_name)
    element(:goal_scorer, into: %GoalScorer{})
    element(:player, into: %Player{})
    elements(:assist, as: :assists, into: %Assist{})
  end
end
