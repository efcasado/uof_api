defmodule UOF.API.Fixtures.ReferenceId do
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @type t :: %__MODULE__{
          name: String.t(),
          value: String.t()
        }

  @primary_key false

  embedded_schema do
    field :name, :string
    field :value, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    cast(model, params, [:name, :value])
  end
end
