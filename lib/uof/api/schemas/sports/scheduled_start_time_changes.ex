defmodule UOF.API.Schemas.Sports.ScheduledStartTimeChanges do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:scheduled_start_time_change, UOF.API.Schemas.Sports.ScheduledStartTimeChange)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:scheduled_start_time_change)
  end
end
