defmodule UOF.API.Utils.HTTP do
  @moduledoc false

  def get(schema, path, params \\ []) do
    client()
    |> Req.get!(url: Enum.join(path, "/"), params: params)
    |> decode(schema)
  end

  def post(schema, path, body \\ "", params \\ []) do
    client()
    |> Req.post!(url: Enum.join(path, "/"), params: params, body: body)
    |> decode(schema)
  end

  defp client do
    Req.new(
      base_url: Application.fetch_env!(:uof_api, :base_url) <> "/",
      headers: %{
        "x-access-token" => Application.fetch_env!(:uof_api, :auth_token),
        "content-type" => "application/xml",
        "accept" => "application/xml"
      }
    )
  end

  defp decode(%Req.Response{body: body}, schema), do: UOF.Schemas.XML.decode(body, schema)
end
