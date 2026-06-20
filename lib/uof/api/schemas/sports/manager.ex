defmodule UOF.API.Schemas.Sports.Manager do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:nationality, :string)
    field(:country_code, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:id, :name, :nationality, :country_code])
  end
end
