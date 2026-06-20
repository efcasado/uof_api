defmodule UOF.API.Schemas.Sports.TvChannels do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_many(:tv_channel, UOF.API.Schemas.Sports.TvChannel)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:tv_channel)
  end
end
