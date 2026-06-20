defmodule UOF.API.Schemas.Sports.PlayerExtended do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:type, :string)
    field(:date_of_birth, :string)
    field(:nationality, :string)
    field(:country_code, :string)
    field(:height, :integer)
    field(:weight, :integer)
    field(:jersey_number, :integer)
    field(:full_name, :string)
    field(:nickname, :string)
    field(:gender, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :type,
      :date_of_birth,
      :nationality,
      :country_code,
      :height,
      :weight,
      :jersey_number,
      :full_name,
      :nickname,
      :gender
    ])
  end
end
