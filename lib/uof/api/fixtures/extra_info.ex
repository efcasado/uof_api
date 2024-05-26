defmodule UOF.API.Fixtures.ExtraInfo do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }

  @primary_key false

  embedded_schema do
    field :key, :string
    field :value, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    cast(model, params, [:key, :value])
  end
end
