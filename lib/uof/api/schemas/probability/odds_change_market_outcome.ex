defmodule UOF.API.Schemas.Probability.OddsChangeMarketOutcome do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:odds, :decimal)
    field(:probabilities, :float)
    field(:win_probabilities, :float)
    field(:lose_probabilities, :float)
    field(:refund_probabilities, :float)
    field(:half_win_probabilities, :float)
    field(:half_lose_probabilities, :float)
    field(:active, :integer)
    field(:team, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :odds,
      :probabilities,
      :win_probabilities,
      :lose_probabilities,
      :refund_probabilities,
      :half_win_probabilities,
      :half_lose_probabilities,
      :active,
      :team
    ])
  end
end
