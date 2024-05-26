defmodule UOF.API.Tournaments.Season do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false

  embedded_schema do
    field :start_date, :string
    field :end_date, :string
    field :year, :string
    field :id, :string
    field :name, :string
    field :tournament_id, :string
  end

  def changeset(%__MODULE__{} = model, params) do
    model
    |> cast(params, [:id, :name, :start_date, :end_date, :year, :tournament_id])
  end
end
