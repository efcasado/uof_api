defmodule UOF.API.Mappings.MarketDescriptions do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Market

  document do
    elements(:market, as: :markets, into: %Market{})
  end
end
