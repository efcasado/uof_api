defmodule UOF.API.Schemas.Sports.Category do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:country_code, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name, :country_code])
  end
end
