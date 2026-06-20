defmodule UOF.API.Schemas.Probability.Clock do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:match_time, :string)
    field(:stoppage_time, :string)
    field(:stoppage_time_announced, :string)
    field(:remaining_time, :string)
    field(:remaining_time_in_period, :string)
    field(:stopped, :boolean)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :match_time,
      :stoppage_time,
      :stoppage_time_announced,
      :remaining_time,
      :remaining_time_in_period,
      :stopped
    ])
  end
end
