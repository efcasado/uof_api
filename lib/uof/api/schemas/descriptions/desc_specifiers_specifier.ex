defmodule UOF.API.Schemas.Descriptions.DescSpecifiersSpecifier do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:name, :string)
    field(:type, :string)
    field(:description, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :type, :description])
  end
end
