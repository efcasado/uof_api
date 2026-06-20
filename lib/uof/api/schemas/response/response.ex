defmodule UOF.API.Schemas.Response.Response do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:action, :string)
    field(:message, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :action, :message])
  end
end
