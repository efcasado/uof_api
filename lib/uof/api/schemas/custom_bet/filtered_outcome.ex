defmodule UOF.API.Schemas.CustomBet.FilteredOutcome do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:conflict, :boolean)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :conflict])
  end
end
