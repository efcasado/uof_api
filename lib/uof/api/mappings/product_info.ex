defmodule UOF.API.Mappings.ProductInfo do
  use Saxaboom.Mapper

  document do
    element(:is_auto_traded)
    element(:is_in_live_score)
    element(:is_in_hosted_statistics)
    element(:is_in_live_center_soccer)
    element(:is_in_live_match_tracker)
    elements(:link, as: :links, value: :name)
  end
end
