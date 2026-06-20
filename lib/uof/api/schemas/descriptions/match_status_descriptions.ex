defmodule UOF.API.Schemas.Descriptions.MatchStatusDescriptions do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:response_code, :string)
    field(:location, :string)
    embeds_many(:match_status, UOF.API.Schemas.Descriptions.DescMatchStatus)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:response_code, :location])
    |> cast_embed(:match_status)
  end
end
