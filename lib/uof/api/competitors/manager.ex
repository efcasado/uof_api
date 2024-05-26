defmodule UOF.API.Competitors.Manager do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :id
    field :name
    field :country_code
    field :nationality
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :id,
      :name,
      :country_code,
      :nationality
    ])
  end
end
