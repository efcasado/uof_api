defmodule UOF.API.Utils.HTTP do
  import Logger

  def get(path) do
    base_url = Application.get_env(:uof_api, :base_url)
    auth_token = Application.get_env(:uof_api, :auth_token)

    url = Enum.join([base_url | path], "/")

    Req.get!(url,
      headers: %{"x-access-token" => auth_token}
    ).body
  end

  def get(path, schema) do
    response = get(path)
    debug("response=#{response}")
    Saxaboom.parse(response, schema)
  end
end
