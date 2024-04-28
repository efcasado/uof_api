defmodule UOF.API.Mappings.ResultChange do
  @moduledoc false
  use Saxaboom.Mapper

  document do
    attribute(:sport_event_id)
    attribute(:update_time)
  end
end
