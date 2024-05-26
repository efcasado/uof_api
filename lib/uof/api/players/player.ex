defmodule UOF.API.Players.Player do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type
    field :date_of_birth
    field :nationality
    field :country_code
    field :height, :integer
    field :weight, :integer
    field :jersey_number, :integer
    field :full_name
    field :gender
    field :id
    field :name
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :type,
      :date_of_birth,
      :nationality,
      :country_code,
      :height,
      :weight,
      :jersey_number,
      :full_name,
      :gender,
      :id,
      :name
    ])
  end
end
