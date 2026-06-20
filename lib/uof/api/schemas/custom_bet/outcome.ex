defmodule UOF.API.Schemas.CustomBet.Outcome do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id])
  end
end
