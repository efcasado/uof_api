defmodule UOF.API.Fixtures.Change do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @type t :: %__MODULE__{
          sport_event_id: String.t(),
          update_time: String.t()
        }

  @primary_key false

  embedded_schema do
    field :sport_event_id, :string
    field :update_time, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    cast(model, params, [:sport_event_id, :update_time])
  end
end
