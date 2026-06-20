defmodule UOF.API.Schemas.Sports.CompetitorReferenceIds do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:reference_id, UOF.API.Schemas.Sports.CompetitorReferenceIdsReferenceId)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:reference_id)
  end
end
