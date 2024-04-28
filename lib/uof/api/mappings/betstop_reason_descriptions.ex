defmodule UOF.API.Mappings.BetStopReasonDescriptions do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.BetStopReason

  @type t :: %__MODULE__{
          reasons: list(BetStopReason.t())
        }

  document do
    elements(:betstop_reason, as: :reasons, into: %BetStopReason{})
  end
end
