defmodule UOF.API.Sports.Sport do
  @moduledoc """
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t()
        }

  @primary_key false

  embedded_schema do
    field :id, :string
    field :name, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    cast(model, params, [:id, :name])
  end
end
