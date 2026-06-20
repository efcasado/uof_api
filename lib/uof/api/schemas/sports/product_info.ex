defmodule UOF.API.Schemas.Sports.ProductInfo do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    embeds_one(:streaming, UOF.API.Schemas.Sports.StreamingChannels)
    embeds_one(:is_in_live_score, UOF.API.Schemas.Sports.ProductInfoItem)
    embeds_one(:is_in_hosted_statistics, UOF.API.Schemas.Sports.ProductInfoItem)
    embeds_one(:is_in_live_center_soccer, UOF.API.Schemas.Sports.ProductInfoItem)
    embeds_one(:is_in_live_match_tracker, UOF.API.Schemas.Sports.ProductInfoItem)
    embeds_one(:is_auto_traded, UOF.API.Schemas.Sports.ProductInfoItem)
    embeds_one(:links, UOF.API.Schemas.Sports.ProductInfoLinks)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [])
    |> cast_embed(:streaming)
    |> cast_embed(:is_in_live_score)
    |> cast_embed(:is_in_hosted_statistics)
    |> cast_embed(:is_in_live_center_soccer)
    |> cast_embed(:is_in_live_match_tracker)
    |> cast_embed(:is_auto_traded)
    |> cast_embed(:links)
  end
end
