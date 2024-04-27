defmodule UOF.API.Mappings.VariantDescriptions do
  use Saxaboom.Mapper

  alias UOF.API.Mappings.Variant

  document do
    elements(:variant, as: :variants, into: %Variant{})
  end
end
