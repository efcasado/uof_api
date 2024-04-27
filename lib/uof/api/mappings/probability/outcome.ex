defmodule UOF.API.Mappings.Probability.Outcome do
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:probabilities, as: :probability, cast: :float)
    attribute(:active, cast: :integer)
  end
end
