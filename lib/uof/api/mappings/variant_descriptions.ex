defmodule UOF.API.Mappings.VariantDescriptions do
  @moduledoc false
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Variant

  document do
    elements(:variant, as: :variants, into: %Variant{})
  end
end
