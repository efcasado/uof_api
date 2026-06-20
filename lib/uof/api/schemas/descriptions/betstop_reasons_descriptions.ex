defmodule UOF.API.Schemas.Descriptions.BetstopReasonsDescriptions do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:betstop_reason, UOF.API.Schemas.Descriptions.DescBetstopReason)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:betstop_reason)
  end
end
