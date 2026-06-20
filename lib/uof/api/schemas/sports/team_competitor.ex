defmodule UOF.API.Schemas.Sports.TeamCompetitor do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :string)
    field(:name, :string)
    field(:abbreviation, :string)
    field(:short_name, :string)
    field(:country, :string)
    field(:country_code, :string)
    field(:virtual, :boolean)
    field(:age_group, :string)
    field(:gender, :string)
    field(:state, :string)
    field(:division, :integer)
    field(:division_name, :string)
    field(:qualifier, :string)
    embeds_one(:reference_ids, UOF.API.Schemas.Sports.CompetitorReferenceIds)
    embeds_one(:players, UOF.API.Schemas.Sports.PlayerExtendedList)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :abbreviation,
      :short_name,
      :country,
      :country_code,
      :virtual,
      :age_group,
      :gender,
      :state,
      :division,
      :division_name,
      :qualifier
    ])
    |> cast_embed(:reference_ids)
    |> cast_embed(:players)
  end
end
