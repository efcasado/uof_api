defmodule UOF.API.Schemas.Sports.WeatherInfo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:temperature_celsius, :integer)
    field(:wind, :string)
    field(:wind_advantage, :string)
    field(:pitch, :string)
    field(:weather_conditions, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:temperature_celsius, :wind, :wind_advantage, :pitch, :weather_conditions])
  end
end
