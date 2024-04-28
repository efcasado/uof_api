defmodule UOF.API.Utils.HTTP do
  @moduledoc false
  import Logger

  def get(schema, path, params \\ []) do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url | path], "/")

    response =
      Req.get!(url,
        headers: %{"x-access-token" => auth_token},
        params: params
      ).body

    debug("response=#{response}")

    case Application.get_env(:uof_api, :parse, true) do
      true ->
        Saxaboom.parse(response, schema)

      false ->
        response
    end
  end
end
