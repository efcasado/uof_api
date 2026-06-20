defmodule UOF.API.Schemas.Probability.OddsChangeMarket do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:favourite, :integer)
    field(:status, :integer)
    field(:cashout_status, :integer)
    field(:id, :integer)
    field(:specifiers, :string)
    field(:extended_specifiers, :string)
    embeds_one(:market_metadata, UOF.API.Schemas.Probability.MarketMetadata)
    embeds_many(:outcome, UOF.API.Schemas.Probability.OddsChangeMarketOutcome)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:favourite, :status, :cashout_status, :id, :specifiers, :extended_specifiers])
    |> cast_embed(:market_metadata)
    |> cast_embed(:outcome)
  end
end
