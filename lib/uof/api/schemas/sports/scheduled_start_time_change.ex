defmodule UOF.API.Schemas.Sports.ScheduledStartTimeChange do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:old_time, :utc_datetime)
    field(:new_time, :utc_datetime)
    field(:changed_at, :utc_datetime)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:old_time, :new_time, :changed_at])
  end
end
