defmodule UOF.API.Mappings.Producer do
  use Saxaboom.Mapper

  document do
    attribute(:id, cast: :integer)
    attribute(:name)
    attribute(:description)
    attribute(:api_url)
    attribute(:active, cast: :boolean)
    attribute(:scope)
    attribute(:stateful_recovery_window_in_minutes, cast: :integer)
  end
end
