defmodule UOF.API.Mappings.Probability.Outcome do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id)
    attribute(:probabilities, as: :probability, cast: :float)
    attribute(:active, cast: :integer)
  end
end
