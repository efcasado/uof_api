defmodule UOF.API.Descriptions.MatchStatus do
  @moduledoc """
  `OddsChange` messages for live matches may be annotated with `MatchStatus`
  information.

  `MatchStatus` provides additional information about the status of a live
  fixture (eg. first period, second break).
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all sport-specific match statuses.

  By default, match status descriptions are provided in English. These can
  be retrieved in another language by specifying a valid language as `lang`.
  """
  @spec all(lang :: String.t()) :: list(MatchStatus.t())
  def all(lang \\ "en") do
    case UOF.API.get("/descriptions/#{lang}/match_status.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("match_status_descriptions")
        |> Map.get("match_status")
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
    field :id, :integer
    field :description, :string
    field :period_number, :integer

    embeds_one :sports, Sports, primary_key: false do
      field :all, :boolean, default: false
      field :ids, {:array, :string}, default: []
    end
  end

  def changeset(model \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = model, params) do
    params = sanitize(params)

    model
    |> cast(params, [:id, :description, :period_number])
    |> cast_embed(:sports, with: &changeset/2)
    |> apply
  end

  def changeset(%UOF.API.Descriptions.MatchStatus.Sports{} = model, params) do
    params =
      params
      |> sanitize
      |> prepare_ids

    model
    |> cast(params, [:all, :ids])
  end

  defp prepare_ids(params) do
    ids =
      params
      |> Map.get("sport", [])
      |> Enum.map(fn
        {"@id", id} -> id
        %{"@id" => id} -> id
      end)

    Map.put(params, "ids", ids)
  end
end
