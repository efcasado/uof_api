defmodule UOF.API.Schemas.Sports.ResultChangesEndpoint do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:generated_at, :utc_datetime)
    embeds_many(:result_change, UOF.API.Schemas.Sports.ResultChange)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:generated_at])
    |> cast_embed(:result_change)
  end
end
