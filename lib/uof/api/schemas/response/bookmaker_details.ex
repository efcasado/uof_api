defmodule UOF.API.Schemas.Response.BookmakerDetails do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:expire_at, :utc_datetime)
    field(:bookmaker_id, :integer)
    field(:virtual_host, :string)
    field(:message, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :expire_at, :bookmaker_id, :virtual_host, :message])
  end
end
