defmodule UOF.API.Schemas.Probability.Cashout do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:product, :integer)
    field(:event_id, :string)
    field(:timestamp, :integer)
    field(:request_id, :integer)
    embeds_one(:sport_event_status, UOF.API.Schemas.Probability.SportEventStatus)
    embeds_one(:odds, UOF.API.Schemas.Probability.CashoutOdds)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:product, :event_id, :timestamp, :request_id])
    |> cast_embed(:sport_event_status)
    |> cast_embed(:odds)
  end
end
