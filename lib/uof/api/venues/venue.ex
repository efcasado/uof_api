defmodule UOF.API.Venues.Venue do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :id
    field :name
    field :capacity, :integer
    field :city_name
    field :country_name
    field :map_coordinates
    field :country_code
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :id,
      :name,
      :capacity,
      :city_name,
      :country_name,
      :map_coordinates,
      :country_code
    ])
  end
end
