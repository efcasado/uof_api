defmodule UOF.API.Schemas.Sports.TvChannel do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:start_time, :utc_datetime)
    field(:stream_url, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :start_time, :stream_url])
  end
end
