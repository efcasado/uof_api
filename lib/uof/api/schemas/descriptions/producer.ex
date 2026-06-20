defmodule UOF.API.Schemas.Descriptions.Producer do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:id, :integer)
    field(:name, :string)
    field(:description, :string)
    field(:api_url, :string)
    field(:active, :boolean)
    field(:scope, :string)
    field(:stateful_recovery_window_in_minutes, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :id,
      :name,
      :description,
      :api_url,
      :active,
      :scope,
      :stateful_recovery_window_in_minutes
    ])
  end
end
