defmodule UOF.API.Users do
  alias UOF.API.Utils.HTTP

  @doc """
  Get information about the token being used.
  """
  def whoami do
    endpoint = ["users", "whoami.xml"]

    HTTP.get(%UOF.API.Mappings.BookmakerDetails{}, endpoint)
  end
end
