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

  @doc """
  List all the available categories for the given sport.
  """
  @spec by_sport(sport :: String.t(), lang :: String.t()) :: list(__MODULE__.t())
  def by_sport(sport, lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/sports/#{sport}/categories.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("sport_categories")
        |> changeset

      {:error, _} = error ->
        error
    end
  end

  @type sport :: %UOF.API.Sports.Category.Sport{
          id: String.t(),
          name: String.t()
        }

  @type category :: %UOF.API.Sports.Category.Category{
          id: String.t(),
          name: String.t(),
          country_code: String.t()
        }

  @type t :: %__MODULE__{
          sport: sport(),
          categories: list(category())
        }

  @primary_key false

  embedded_schema do
    embeds_one :sport, Sport, primary_key: false do
      field :id, :string
      field :name, :string
    end

    embeds_many :categories, Category, primary_key: false do
      field :id, :string
      field :name, :string
      field :country_code, :string
    end
  end

  @doc false
  def changeset(model \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = model, params) do
    params = bubble_up(params, "categories", "category")

    model
    |> cast(params, [])
    |> cast_embed(:sport, with: &changeset/2)
    |> cast_embed(:categories, with: &changeset/2)
    |> apply
  end

  def changeset(%UOF.API.Sports.Category.Sport{} = model, params) do
    params = sanitize(params)

    model
    |> cast(params, [:id, :name])
  end

  def changeset(%UOF.API.Sports.Category.Category{} = model, params) do
    params = sanitize(params)

    model
    |> cast(params, [:id, :name, :country_code])
  end
end
