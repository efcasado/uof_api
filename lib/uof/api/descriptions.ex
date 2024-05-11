defmodule UOF.API.Descriptions do
  alias UOF.API.Utils.HTTP

  @doc """
  Describe all currently available markets.
  """
  def markets(lang \\ "en") do
    # TO-DO: Optional mappings
    endpoint = ["descriptions", lang, "markets.xml"]

    HTTP.get(%UOF.API.Mappings.MarketDescriptions{}, endpoint)
  end

  @doc """
  Get a list of all variants and which markets they are used for.
  """
  def variants(lang \\ "en") do
    endpoint = ["descriptions", lang, "variants.xml"]

    HTTP.get(%UOF.API.Mappings.VariantDescriptions{}, endpoint)
  end

  @doc """
  Describe all currently avbailable producers and their ids.
  """
  def producers do
    endpoint = ["descriptions", "producers.xml"]

    HTTP.get(%UOF.API.Mappings.Producers{}, endpoint)
  end
end
