defmodule UOF.API.Mappings.Variant do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.{OutcomeMappings, Outcome}

  document do
    attribute(:id)
    elements(:outcome, as: :outcomes, into: %Outcome{})
    elements(:mapping, as: :mappings, into: %OutcomeMappings{})
  end
end
