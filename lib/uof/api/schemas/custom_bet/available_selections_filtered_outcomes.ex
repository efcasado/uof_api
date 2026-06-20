defmodule UOF.API.Schemas.CustomBet.AvailableSelectionsFilteredOutcomes do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:event, UOF.API.Schemas.CustomBet.FilteredEvent)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:event)
  end
end
