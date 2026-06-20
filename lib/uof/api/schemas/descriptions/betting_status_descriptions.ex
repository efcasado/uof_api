defmodule UOF.API.Schemas.Descriptions.BettingStatusDescriptions do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:betting_status, UOF.API.Schemas.Descriptions.DescBettingStatus)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:betting_status)
  end
end
