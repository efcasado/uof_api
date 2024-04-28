defmodule UOF.API.Mappings.Jersey do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:type)
    attribute(:base)
    attribute(:sleeve)
    attribute(:number)
    attribute(:stripes, cast: :boolean)
    attribute(:horizontal_stripes, cast: :boolean)
    attribute(:squares, cast: :boolean)
    attribute(:split, cast: :boolean)
    attribute(:shirt_type)
  end
end
