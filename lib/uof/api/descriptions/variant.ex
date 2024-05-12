defmodule UOF.API.Descriptions.Variant do
  @moduledoc """
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all variants.
  """
  @spec all(lang :: String.t()) :: list(Variant.t())
  def all(lang \\ "en") do
    case UOF.API.get("/descriptions/#{lang}/variants.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("variant_descriptions")
        |> Map.get("variant")
        |> Enum.map(fn x ->
          {:ok, x} = changeset(x)
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @primary_key false

  embedded_schema do
    field(:id, :string)

    embeds_many :outcomes, Outcome, primary_key: false do
      field(:id, :string)
      field(:name, :string)
    end

    embeds_many :mappings, Mapping, primary_key: false do
      field(:product_id, :integer)
      field(:product_ids, {:array, :integer})
      field(:sport_id, :string)
      field(:market_id, :integer)
      field(:product_market_id, :string)

      embeds_many :outcome_mappings, OutcomeMapping, primary_key: false do
        field(:outcome_id, :string)
        field(:product_outcome_id, :integer)
        field(:product_outcome_name, :string)
      end
    end
  end

  def changeset(model \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = model, params) do
    params =
      params
      |> sanitize
      |> bubble_up("outcomes", "outcome")
      |> bubble_up("mappings", "mapping")

    model
    |> cast(params, [:id])
    |> cast_embed(:outcomes, with: &changeset/2)
    |> cast_embed(:mappings, with: &changeset/2)
    |> apply
  end

  def changeset(%UOF.API.Descriptions.Variant.Outcome{} = model, params) do
    params = sanitize(params)

    model
    |> cast(params, [:id, :name])
  end

  def changeset(%UOF.API.Descriptions.Variant.Mapping{} = model, params) do
    params =
      params
      |> sanitize
      |> split("product_ids", "|")
      |> rename("mapping_outcome", "outcome_mappings", [])

    model
    |> cast(params, [:product_id, :product_ids, :sport_id, :market_id, :product_market_id])
    |> cast_embed(:outcome_mappings, with: &changeset/2)
  end

  def changeset(%UOF.API.Descriptions.Variant.Mapping.OutcomeMapping{} = model, params) do
    params = sanitize(params)

    model
    |> cast(params, [:outcome_id, :product_outcome_id, :product_outcome_name])
  end
end
