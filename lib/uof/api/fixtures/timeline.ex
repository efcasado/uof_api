defmodule UOF.API.Fixtures.Timeline do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  # element(:sport_event, into: %SportEvent{})
  # element(:sport_event_conditions, as: :event_conditions, into: %EventConditions{})
  # element(:sport_event_status, as: :event_status, into: %SportEventStatus{})
  # element(:coverage_info, into: %CoverageInfo{})

  @primary_key false

  embedded_schema do
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [])
  end
end
