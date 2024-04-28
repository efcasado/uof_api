defmodule UOF.API.Mappings.MatchStatusDescriptions do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.MatchStatus

  document do
    elements(:match_status, as: :statuses, into: %MatchStatus{})
  end
end
