defmodule UOF.API.Sports.Sport do
  @moduledoc """
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all the available sports.
  """
  @spec all(lang :: String.t()) :: list(__MODULE__.t())
  def all(lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/sports.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("sports")
        |> Map.get("sport")
        |> Enum.map(fn x ->
          {:ok, x} = apply(changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

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
