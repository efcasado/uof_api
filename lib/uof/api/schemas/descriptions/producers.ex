defmodule UOF.API.Schemas.Descriptions.Producers do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:producer, UOF.API.Schemas.Descriptions.Producer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:producer)
  end
end
