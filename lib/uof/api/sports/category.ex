# https://docs.betradar.com/pages/viewpage.action?pageId=116065083
defmodule UOF.API.Sports.Category do
  @moduledoc """
  Categories are a generic classification term Betradar uses to subclassify a
  particular sport (e.g. for Tennis the categories can be ATP-Tour, WTA-Tour,
  David Cup, etc., for soccer the categories are the various countries).
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @type t :: %UOF.API.Sports.Category{
          id: String.t(),
          name: String.t(),
          country_code: String.t()
        }

  @primary_key false

  embedded_schema do
    field :id, :string
    field :name, :string
    field :country_code, :string
  end

  @doc false
  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [:id, :name, :country_code])
  end
end
