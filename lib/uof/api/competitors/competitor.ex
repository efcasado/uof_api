defmodule UOF.API.Competitors.Competitor do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :id
    field :name
    field :state
    field :country
    field :country_code
    field :abbreviation
    field :qualifier
    field :virtual
    field :gender
    field :short_name
    embeds_one :sport, UOF.API.Sports.Sport
    embeds_one :category, UOF.API.Sports.Category
    # embeds_many, :reference_id
  end

  def changeset(model \\ %__MODULE__{}, params) do
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
    |> cast_embed(:sport)
    |> cast_embed(:category)
  end
end
