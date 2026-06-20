defmodule UOF.API.Schemas.Sports.SportEvent do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:liveodds, :string)
    field(:status, :string)
    field(:next_live_time, :string)
    field(:id, :string)
    field(:name, :string)
    field(:type, :string)
    field(:stage_type, :string)
    field(:scheduled, :utc_datetime)
    field(:start_time_tbd, :boolean)
    field(:scheduled_end, :utc_datetime)
    field(:replaced_by, :string)
    embeds_one(:tournament_round, UOF.API.Schemas.Sports.MatchRound)
    embeds_one(:season, UOF.API.Schemas.Sports.SeasonExtended)
    embeds_one(:parent, UOF.API.Schemas.Sports.ParentStage)
    embeds_one(:additional_parents, UOF.API.Schemas.Sports.SportEventAdditionalParents)
    embeds_one(:tournament, UOF.API.Schemas.Sports.Tournament)
    embeds_one(:sport_event_conditions, UOF.API.Schemas.Sports.SportEventConditions)
    embeds_one(:competitors, UOF.API.Schemas.Sports.SportEventCompetitors)
    embeds_one(:races, UOF.API.Schemas.Sports.SportEventChildren)
    embeds_one(:venue, UOF.API.Schemas.Sports.Venue)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :liveodds,
      :status,
      :next_live_time,
      :id,
      :name,
      :type,
      :stage_type,
      :scheduled,
      :start_time_tbd,
      :scheduled_end,
      :replaced_by
    ])
    |> cast_embed(:tournament_round)
    |> cast_embed(:season)
    |> cast_embed(:parent)
    |> cast_embed(:additional_parents)
    |> cast_embed(:tournament)
    |> cast_embed(:sport_event_conditions)
    |> cast_embed(:competitors)
    |> cast_embed(:races)
    |> cast_embed(:venue)
  end
end
