defmodule UOF.API.Mappings.BetStopReason do
  @moduledoc false
  use Saxaboom.Mapper

  @type t :: %__MODULE__{
          id: integer,
          description: String.t()
        }

  document do
    attribute(:id, cast: :integer)
    attribute(:description)
  end
end
