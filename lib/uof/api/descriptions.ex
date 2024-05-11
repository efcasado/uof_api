defmodule UOF.API.Descriptions do
  alias UOF.API.Utils.HTTP

  @doc """
  Get a list of all variants and which markets they are used for.
  """
  def variants(lang \\ "en") do
    endpoint = ["descriptions", lang, "variants.xml"]

    HTTP.get(%UOF.API.Mappings.VariantDescriptions{}, endpoint)
  end
end
