defmodule UOF.API.Booking do
  @moduledoc """
  Booking Calendar API.

  Booking makes a sport event available for live odds. The HTTP response is only
  an acknowledgement (`UOF.API.Schemas.Response.Response`).

  There are no GET endpoints for the booking calendar — booking state is exposed
  on schedule responses via the `liveodds` attribute (`"booked"`, `"bookable"`,
  `"buyable"`, `"unavailable"`), e.g. on the fixtures returned by
  `UOF.API.Sports.schedule/2`.
  """
  alias UOF.API.Schemas.Response.Response
  alias UOF.API.Utils.HTTP

  @doc """
  Book the given `sport_event` (e.g. `"sr:match:12345"`) for live odds.
  """
  def book(sport_event) do
    endpoint = ["liveodds", "booking-calendar", "events", sport_event, "book"]
    HTTP.post(Response, endpoint)
  end
end
