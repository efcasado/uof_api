defmodule UOF.API.Mappings.Jersey do
  use Saxaboom.Mapper

  document do
    attribute(:type)
    attribute(:base)
    attribute(:sleeve)
    attribute(:number)
    attribute(:stripes)
    attribute(:horizontal_stripes)
    attribute(:squares)
    attribute(:split)
    attribute(:shirt_type)
  end
end
