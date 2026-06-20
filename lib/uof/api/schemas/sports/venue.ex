defmodule UOF.API.Schemas.Sports.Venue do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:capacity, :integer)
    field(:city_name, :string)
    field(:country_name, :string)
    field(:country_code, :string)
    field(:map_coordinates, :string)
    field(:state, :string)
    embeds_many(:course, UOF.API.Schemas.Sports.Course)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :capacity,
      :city_name,
      :country_name,
      :country_code,
      :map_coordinates,
      :state
    ])
    |> cast_embed(:course)
  end
end
