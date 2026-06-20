defmodule UOF.API.Schemas.Sports.Jersey do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:type, :string)
    field(:base, :string)
    field(:sleeve, :string)
    field(:number, :string)
    field(:stripes, :boolean)
    field(:stripes_color, :string)
    field(:horizontal_stripes, :boolean)
    field(:horizontal_stripes_color, :string)
    field(:squares, :boolean)
    field(:squares_color, :string)
    field(:split, :boolean)
    field(:split_color, :string)
    field(:shirt_type, :string)
    field(:sleeve_detail, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :type,
      :base,
      :sleeve,
      :number,
      :stripes,
      :stripes_color,
      :horizontal_stripes,
      :horizontal_stripes_color,
      :squares,
      :squares_color,
      :split,
      :split_color,
      :shirt_type,
      :sleeve_detail
    ])
  end
end
