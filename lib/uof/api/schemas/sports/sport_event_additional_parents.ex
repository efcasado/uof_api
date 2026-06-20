defmodule UOF.API.Schemas.Sports.SportEventAdditionalParents do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:parent, UOF.API.Schemas.Sports.ParentStage)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:parent)
  end
end
