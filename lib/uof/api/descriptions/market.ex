defmodule UOF.API.Descriptions.Market do
  @moduledoc """
  Markets are the betting proposition with outcomes on which punters place their
  bets. Different types of markets are defined for different fixtures.
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all supported markets.
  """
  @spec all(include_mappings? :: boolean(), lang :: String.t()) :: list(Market.t())
  def all(include_mappings? \\ false, lang \\ "en") do
    case UOF.API.get("/descriptions/#{lang}/markets.xml",
           query: [include_mappings: include_mappings?]
         ) do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("market_descriptions")
        |> Map.get("market")
        |> Enum.map(fn x ->
          {:ok, x} = changeset(x)
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @doc """
  """
  # UOF.API.Descriptions.Market.variant(241, "sr:exact_games:bestof:7")
  def variant(market, variant, include_mappings? \\ false, lang \\ "en") do
    case UOF.API.get("/descriptions/#{lang}/markets/#{market}/variants/#{variant}",
           query: [include_mappings: include_mappings?]
         ) do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("market_descriptions")
        |> Map.get("market")

      # |> Enum.map(fn x ->
      #   {:ok, x} = changeset(x)
      #   x
      # end)

      {:error, _} = error ->
        error
    end
  end

  @primary_key false

  embedded_schema do
    field :id, :integer
    field :name, :string
    field :groups, {:array, :string}
    # ["player", "competitor", "free_text"]
    field :outcome_type, :string
    field :includes_outcomes_of_type, :string

    embeds_many :outcomes, Outcome, primary_key: false do
      field :id, :integer
      field :name, :string
    end

    embeds_many :specifiers, Specifier, primary_key: false do
      # ["decimal", "integer", "string", "variable_text"]
      field :type, :string
      field :name, :string
    end

    # TO-DO: embeds_many(:mappings, Mapping)
  end

  def changeset(model \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = model, params) do
    params =
      params
      |> bubble_up("outcomes", "outcome")
      |> bubble_up("specifiers", "specifier")
      |> split("groups", "|")

    model
    |> cast(params, [:id, :name, :groups, :outcome_type, :includes_outcomes_of_type])
    |> cast_embed(:outcomes, with: &changeset/2)
    |> cast_embed(:specifiers, with: &changeset/2)
    |> apply
  end

  def changeset(%UOF.API.Descriptions.Market.Outcome{} = model, params) do
    cast(model, params, [:id, :name])
  end

  def changeset(%UOF.API.Descriptions.Market.Specifier{} = model, params) do
    cast(model, params, [:type, :name])
  end
end
