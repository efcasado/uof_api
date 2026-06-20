defmodule UOF.API.Schemas.Sports.SeasonExtended do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:start_date, :date)
    field(:end_date, :date)
    field(:start_time, :time)
    field(:end_time, :time)
    field(:year, :string)
    field(:tournament_id, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :start_date,
      :end_date,
      :start_time,
      :end_time,
      :year,
      :tournament_id
    ])
  end
end
