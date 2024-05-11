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

  defmodule Outcome do
    @moduledoc false
    use Ecto.Schema
    import Ecto.Changeset
    import UOF.API.EctoHelpers

    @primary_key false

    embedded_schema do
      field(:id, :integer)
      field(:name, :string)
    end

    def changeset(model \\ %__MODULE__{}, params) do
      cast(model, prepare(params), [:id, :name])
    end

    defp prepare(params) do
      params
      |> rename_fields
    end
  end

  defmodule Specifier do
    @moduledoc false
    use Ecto.Schema
    import Ecto.Changeset
    import UOF.API.EctoHelpers

    @primary_key false

    embedded_schema do
      # ["decimal", "integer", "string", "variable_text"]
      field(:type, :string)
      field(:name, :string)
    end

    def changeset(model \\ %__MODULE__{}, params) do
      cast(model, prepare(params), [:name, :type])
    end

    defp prepare(params) do
      params
      |> rename_fields
    end
  end

  @primary_key false

  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:groups, {:array, :string})
    # ["player", "competitor", "free_text"]
    field(:outcome_type, :string)
    field(:includes_outcomes_of_type, :string)
    embeds_many(:outcomes, Outcome)
    embeds_many(:specifiers, Specifier)
    # TO-DO: embeds_many(:mappings, Mapping)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(prepare(params), [:id, :name, :groups, :outcome_type, :includes_outcomes_of_type])
    |> cast_embed(:outcomes)
    |> cast_embed(:specifiers)
    |> case do
      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, apply_changes(changeset)}

      %Ecto.Changeset{} = changeset ->
        {:error, {params, traverse_errors(changeset)}}
    end
  end

  defp prepare(params) do
    params
    |> rename_fields
    |> prepare_outcomes
    |> prepare_specifiers
    |> split_groups
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

  defp prepare_specifiers(params) do
    specifiers =
      params
      |> Map.get("specifiers", %{})
      |> Map.get("specifier", [])

    case specifiers do
      specifier when not is_list(specifier) ->
        Map.put(params, "specifiers", [specifier])

      _ ->
        Map.put(params, "specifiers", specifiers)
    end
  end

  defp split_groups(params) do
    scope = String.split(params["groups"], "|")
    Map.put(params, "groups", scope)
  end
end
