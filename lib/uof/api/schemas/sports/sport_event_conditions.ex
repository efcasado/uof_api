defmodule UOF.API.Schemas.Sports.SportEventConditions do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:attendance, :string)
    field(:match_mode, :string)
    embeds_one(:referee, UOF.API.Schemas.Sports.Referee)
    embeds_one(:pitchers, UOF.API.Schemas.Sports.Pitchers)
    embeds_one(:pitcherHistory, UOF.API.Schemas.Sports.PitcherHistory)
    embeds_one(:venue, UOF.API.Schemas.Sports.Venue)
    embeds_one(:weather_info, UOF.API.Schemas.Sports.WeatherInfo)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:attendance, :match_mode])
    |> cast_embed(:referee)
    |> cast_embed(:pitchers)
    |> cast_embed(:pitcherHistory)
    |> cast_embed(:venue)
    |> cast_embed(:weather_info)
  end
end
