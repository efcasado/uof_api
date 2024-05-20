# https://docs.betradar.com/display/BD/UOF+-+Tournament+we+provide+coverage+for
defmodule UOF.API.Sports.Tournament do
  @moduledoc """
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all the available tournaments.
  """
  @spec all(lang :: String.t()) :: list(__MODULE__.t())
  def all(lang \\ "en") do
    case UOF.API.get("/sports/#{lang}/tournaments.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("tournaments")
        |> Map.get("tournament")
        |> Enum.map(fn x ->
          {:ok, x} = apply(changeset(x))
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Show the details of the given tournament.
  """
  def show(tournament, lang \\ "en") do
    # TO-DO: staged tournaments
    # https://docs.betradar.com/display/BD/UOF+-+Formula+1
    case UOF.API.get("/sports/#{lang}/tournaments/#{tournament}/info.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> UOF.API.Tournaments.TournamentInfo.changeset()
        |> apply

      {:error, _} = error ->
        error
    end
  end

  @type current_season :: %UOF.API.Sports.Tournament.CurrentSeason{
          start_date: String.t(),
          end_date: String.t(),
          year: String.t(),
          id: String.t(),
          name: String.t()
        }

  @type season_coverage_info :: %UOF.API.Sports.Tournament.SeasonCoverageInfo{
          season_id: String.t(),
          scheduled: integer(),
          played: integer(),
          max_coverage_level: String.t(),
          max_covered: integer(),
          min_coverage_level: String.t()
        }

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          sport: UOF.API.Sports.Sport.t(),
          category: UOF.API.Sports.Category.t(),
          current_season: current_season(),
          season_coverage_info: season_coverage_info()
        }

  @primary_key false

  embedded_schema do
    field :id, :string
    field :name, :string

    embeds_one :current_season, CurrentSeason, primary_key: false do
      field :start_date, :string
      field :end_date, :string
      field :year, :string
      field :id, :string
      field :name, :string
    end

    embeds_one :season_coverage_info, SeasonCoverageInfo, primary_key: false do
      field :season_id, :string
      field :scheduled, :integer
      field :played, :integer
      field :max_coverage_level, :string
      field :max_covered, :integer
      field :min_coverage_level, :string
    end

    embeds_one :sport, UOF.API.Sports.Sport
    embeds_one :category, UOF.API.Sports.Category.Category
  end

  def from_simple_form({element, attrs, elements}) do
    %{element => Map.new(attrs ++ elements)}
  end

  def changeset(model \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, [:id, :name])
    |> cast_embed(:sport)
    |> cast_embed(:category, with: &UOF.API.Sports.Category.changeset/2)
    |> cast_embed(:current_season, with: &changeset/2)
    |> cast_embed(:season_coverage_info, with: &changeset/2)
  end

  def changeset(%UOF.API.Sports.Tournament.CurrentSeason{} = model, params) do
    model
    |> cast(params, [:id, :name, :start_date, :end_date, :year])
  end

  def changeset(%UOF.API.Sports.Tournament.SeasonCoverageInfo{} = model, params) do
    model
    |> cast(params, [
      :season_id,
      :scheduled,
      :played,
      :max_coverage_level,
      :max_covered,
      :min_coverage_level
    ])
  end
end
