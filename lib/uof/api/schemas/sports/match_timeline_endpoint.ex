defmodule UOF.API.Schemas.Sports.MatchTimelineEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_one(:sport_event, UOF.API.Schemas.Sports.SportEvent)
    embeds_one(:sport_event_conditions, UOF.API.Schemas.Sports.SportEventConditions)
    embeds_one(:sport_event_status, UOF.API.Schemas.Sports.SportEventStatus)
    embeds_one(:coverage_info, UOF.API.Schemas.Sports.CoverageInfo)
    embeds_one(:timeline, UOF.API.Schemas.Sports.Timeline)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:sport_event)
    |> cast_embed(:sport_event_conditions)
    |> cast_embed(:sport_event_status)
    |> cast_embed(:coverage_info)
    |> cast_embed(:timeline)
  end
end
