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

  def changeset(model \\ %__MODULE__{}, params) do
    params = prepare(params)

    model
    |> cast(params, [:id])
    |> cast_embed(:outcomes, with: &outcome_changeset/2)
    |> cast_embed(:mappings, with: &mapping_changeset/2)
    |> apply
  end

  defp prepare(params) do
    params
    |> rename_fields
    |> prepare_outcomes
    |> prepare_mappings
  end

  defp prepare_outcomes(params) do
    outcomes =
      params
      |> Map.get("outcomes", %{})
      |> Map.get("outcome", [])

    case outcomes do
      outcome when not is_list(outcome) ->
        Map.put(params, "outcomes", [outcome])

      _ ->
        Map.put(params, "outcomes", outcomes)
    end
  end

  defp prepare_mappings(params) do
    mappings =
      params
      |> Map.get("mappings", %{})
      |> Map.get("mapping", [])

    case mappings do
      mapping when not is_list(mapping) ->
        Map.put(params, "mappings", [mapping])

      _ ->
        Map.put(params, "mappings", mappings)
    end
  end

  def outcome_changeset(model, params) do
    params = prepare_outcome(params)

    model
    |> cast(params, [:id, :name])
  end

  def prepare_outcome(params) do
    params
    |> rename_fields
  end

  def mapping_changeset(model, params) do
    params = prepare_mapping(params)

    model
    |> cast(params, [:product_id, :product_ids, :sport_id, :market_id, :product_market_id])
    |> cast_embed(:outcome_mappings, with: &outcome_mapping_changeset/2)
  end

  def prepare_mapping(params) do
    params
    |> rename_fields
    |> split("product_ids", "|")
    |> rename("mapping_outcome", "outcome_mappings", [])
  end

  def outcome_mapping_changeset(model, params) do
    params = prepare_outcome_mapping(params)

    model
    |> cast(params, [:outcome_id, :product_outcome_id, :product_outcome_name])
  end

  def prepare_outcome_mapping(params) do
    params
    |> rename_fields
  end
end
