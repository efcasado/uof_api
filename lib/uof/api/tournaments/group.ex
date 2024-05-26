defmodule UOF.API.Tournaments.Group do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @primary_key false

  # Example. sr:tournament:1211
  embedded_schema do
    field :id, :string
    field :name, :string

    embeds_many :competitors, Competitor, primary_key: false do
      field :id, :string
      field :name, :string
      field :state, :string
      field :country, :string
      field :country_code, :string
      field :abbreviation, :string
      field :qualifier, :string
      field :virtual, :string
      field :gender, :string
      field :short_name, :string

      embeds_many :references, Reference, primary_key: false do
        field :name, :string
        field :value, :string
      end
    end
  end

  def changeset(model \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{} = model, params) do
    params = rename(params, "competitor", "competitors", [])

    model
    |> cast(params, [:id, :name])
    |> cast_embed(:competitors, with: &changeset/2)
  end

  def changeset(%UOF.API.Tournaments.Group.Competitor{} = model, params) do
    params =
      params
      |> bubble_up("reference_ids", "reference_id")
      |> rename("reference_ids", "references", [])

    model
    |> cast(params, [
      :id,
      :name,
      :state,
      :country,
      :country_code,
      :abbreviation,
      :qualifier,
      :virtual,
      :gender,
      :short_name
    ])
    |> cast_embed(:references, with: &changeset/2)
  end

  def changeset(%UOF.API.Tournaments.Group.Competitor.Reference{} = model, params) do
    model
    |> cast(params, [:name, :value])
  end
end
