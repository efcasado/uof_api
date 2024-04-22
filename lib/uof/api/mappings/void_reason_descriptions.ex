defmodule UOF.API.Mappings.VoidReasonDescriptions do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.VoidReason

  document do
    elements(:void_reason, as: :reasons, into: %VoidReason{})
  end
end
