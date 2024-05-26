defmodule UOF.API.Competitors.CompetitorProfile do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    embeds_one :competitor, UOF.API.Competitors.Competitor
    embeds_one :manager, UOF.API.Competitors.Manager
    embeds_one :venue, UOF.API.Venues.Venue
    embeds_many :jerseys, UOF.API.Competitors.Jersey
    embeds_many :players, UOF.API.Players.Player
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [])
    |> cast_embed(:competitor)
    |> cast_embed(:manager)
    |> cast_embed(:venue)
    |> cast_embed(:jerseys)
    |> cast_embed(:players)
  end
end
