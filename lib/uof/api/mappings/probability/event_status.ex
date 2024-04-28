defmodule UOF.API.Mappings.Probability.EventStatus do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:status, cast: :integer)
    attribute(:match_status, cast: :integer)
  end
end
