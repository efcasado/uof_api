defmodule UOF.API.Schemas.CustomBet.Response do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:generated_at, :utc_datetime)
    field(:message, :string)
    field(:errors, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :generated_at, :message, :errors])
  end
end
