defmodule UOF.API.Mappings.BettingStatusDescriptions do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.BettingStatus

  @type t :: %__MODULE__{
          statuses: list(BettingStatus.t())
        }

  document do
    elements(:betting_status, as: :statuses, into: %BettingStatus{})
  end
end
