defmodule UOF.API.Users do
  @moduledoc """
  API used for administrative purposes.
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  Get information about the token being used, including information such as
  the caller's bookmaker id and when the caller's access token will expire.
  """
  def whoami do
    case UOF.API.get("/users/whoami.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> UOF.API.Utils.xml_to_map()
        |> Map.get("bookmaker_details")
        |> changeset

      {:error, _} = error ->
        error
    end
  end

  @primary_key false

  embedded_schema do
    field :expire_at, :string
    field :bookmaker_id, :string
    field :virtual_host, :string
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, [:expire_at, :bookmaker_id, :virtual_host])
    |> apply
  end
end
