defmodule UOF.API.Probability do
  alias UOF.API.Utils.HTTP

  @doc """
  Get probabilities for the given fixture.
  """
  def probabilities(fixture) do
    endpoint = ["probabilities", fixture]
    HTTP.get(%UOF.API.Mappings.Probability.Cashout{}, endpoint)
  end

  @doc """
  Get probabilities for the specified market in the given fixture.
  """
  def probabilities(fixture, market) do
    endpoint = ["probabilities", fixture, market]
    HTTP.get(%UOF.API.Mappings.Probability.Cashout{}, endpoint)
  end

  @doc """
  Get probabilities for the specified market with specifier in the given fixture.
  """
  def probabilities(fixture, market, specifier) do
    endpoint = ["probabilities", fixture, market, specifier]
    HTTP.get(%UOF.API.Mappings.Probability.Cashout{}, endpoint)
  end
end
