defmodule UOF.API.Schemas.CustomBet.FilteredMarket do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:specifiers, :string)
    field(:conflict, :boolean)
    embeds_many(:outcome, UOF.API.Schemas.CustomBet.FilteredOutcome)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :specifiers, :conflict])
    |> cast_embed(:outcome)
  end
end
