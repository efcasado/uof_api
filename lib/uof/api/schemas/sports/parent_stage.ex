defmodule UOF.API.Schemas.Sports.ParentStage do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:type, :string)
    field(:stage_type, :string)
    field(:scheduled, :utc_datetime)
    field(:start_time_tbd, :boolean)
    field(:scheduled_end, :utc_datetime)
    field(:replaced_by, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :type,
      :stage_type,
      :scheduled,
      :start_time_tbd,
      :scheduled_end,
      :replaced_by
    ])
  end
end
