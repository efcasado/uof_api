defmodule UOF.API.Schemas.Sports.ResultChange do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:sport_event_id, :string)
    field(:update_time, :utc_datetime)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:sport_event_id, :update_time])
  end
end
