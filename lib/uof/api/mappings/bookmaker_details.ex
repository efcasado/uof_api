defmodule UOF.API.Mappings.BookmakerDetails do
  use Saxaboom.Mapper

  @type t :: %__MODULE__{
          expire_at: String.t(),
          bookmaker_id: String.t(),
          virtual_host: String.t()
        }
  document do
    attribute(:expire_at)
    attribute(:bookmaker_id)
    attribute(:virtual_host)
  end
end
