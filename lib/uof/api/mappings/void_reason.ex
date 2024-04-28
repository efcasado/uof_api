defmodule UOF.API.Mappings.VoidReason do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:id, cast: :integer)
    attribute(:description)
  end
end
