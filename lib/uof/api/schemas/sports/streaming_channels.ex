defmodule UOF.API.Schemas.Sports.StreamingChannels do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:channel, UOF.API.Schemas.Sports.StreamingChannel)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:channel)
  end
end
