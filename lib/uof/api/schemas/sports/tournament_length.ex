defmodule UOF.API.Schemas.Sports.TournamentLength do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:start_date, :date)
    field(:end_date, :date)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:start_date, :end_date])
  end
end
