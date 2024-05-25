defmodule UOF.API.Fixtures.Venue do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @primary_key false

  embedded_schema do
    field :id, :string
    field :name, :string
    field :capacity, :integer
    field :city_name, :string
    field :country_name, :string
    field :map_coordinates, :string
    field :country_code, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :id,
      :name,
      :capacity,
      :city_name,
      :country_name,
      :country_code,
      :map_coordinates
    ])
  end
end
