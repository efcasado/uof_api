defmodule UOF.API.Schemas.Probability.MarketMetadata do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:next_betstop, :integer)
    field(:start_time, :integer)
    field(:end_time, :integer)
    field(:aams_id, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:next_betstop, :start_time, :end_time, :aams_id])
  end
end
