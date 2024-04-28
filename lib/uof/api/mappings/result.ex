defmodule UOF.API.Mappings.Result do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:home_score, cast: :integer)
    attribute(:away_score, cast: :integer)
    attribute(:match_status_code, cast: :integer)
  end
end
