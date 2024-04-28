![UOF API](https://github.com/efcasado/uof_api/raw/main/assets/readme_logo.png)

[![Build Status](https://github.com/efcasado/uof_api/actions/workflows/elixir.yml/badge.svg?branch=main)](https://github.com/efcasado/uof_api/actions)

# UOF API

Elixir client for Betradar's Unified Odds Feed (UOF) HTTP API.

> [!IMPORTANT]
> This is an **unofficial client** for Betradar's Unified Odds Feed (UOF) HTTP API.
> Betradar offers official Java and .NET SDKs. You can read more about these
> [here](https://sdk.sportradar.com).


### Get Started

```
make
```


### Examples

#### Probability API

The example below illustrates how to use different functions from `UOF API` to
fetch the probabilities of a random fixture.

```elixir
# configuration
:ok = Application.put_env(:uof_api, :base_url, "<betradar-uof-base-url>")
:ok = Application.put_env(:uof_api, :auth_token, "<betradar-uof-base-url>")

# sports supported by probability api
supported_sports = [
  "Soccer",
  "Baseball",
  "Basketball",
  "Tennis",
  "Table Tennis",
  "Badminton",
  "Volleyball",
  "Squash",
  "Handball",
  "Ice Hockey",
  "Field Hockey"
]

sports = UOF.API.Sports.sports
|> then(fn({:ok, resp}) -> resp.sports end)
|> Enum.filter(&(&1.name in supported_sports))

# fetch probabilities of a random fixture
UOF.API.Sports.live_schedule
|> then(fn({:ok, schedule}) -> schedule.fixtures end)
|> Enum.filter(&(&1.status == "live" && &1.liveodds == "booked" && &1.tournament.sport in sports))
|> Enum.shuffle
|> hd
|> then(fn(fixture) -> UOF.API.Probability.probabilities(fixture.id) end)
```

#### Custom Bet API

```elixir
# configuration
:ok = Application.put_env(:uof_api, :base_url, "<betradar-uof-base-url>")
:ok = Application.put_env(:uof_api, :auth_token, "<betradar-uof-base-url>")

{:ok, schedule} = UOF.API.Sports.live_schedule

fixture = schedule.events
|> Enum.filter(&(&1.liveodds == "booked" && &1.status != "ended" && &1.tournament.sport.id == "sr:sport:1" && &1.venue != nil))
|> Enum.shuffle
|> hd

{:ok, available} = UOF.API.CustomBet.available_selections(fixture.id)
```