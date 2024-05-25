defmodule UOF.API.Competitors.Jersey do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :type
    field :base
    field :sleeve
    field :number
    field :stripes, :boolean
    field :horizontal_stripes, :boolean
    field :squares, :boolean
    field :split, :boolean
    field :shirt_type
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [
      :type,
      :base,
      :sleeve,
      :number,
      :stripes,
      :horizontal_stripes,
      :squares,
      :split,
      :shirt_type
    ])
  end
end
