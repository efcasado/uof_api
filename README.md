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
defmodule Utils do
  def build(fixture, length) when length > 1 do
    {:ok, available} = UOF.API.CustomBet.available_selections(fixture)

    {mid, mspecs, oid} = random_selection(available.markets)
    do_build(fixture, length - 1, {nil, nil, [{fixture, mid, oid, mspecs}]})
  end

  defp do_build(_fixture, 0, {odds, probs, sels}) do
    {odds, probs, sels}
  end

  defp do_build(fixture, n, {_, _, sels}) do
    {:ok, calc} = UOF.API.CustomBet.calculate(sels, true)
    {mid, mspecs, oid} = random_selection(calc.available_selections.markets)
    do_build(fixture, n - 1, {calc.odds, calc.probability, [{fixture, mid, oid, mspecs} | sels]})
  end

  def random_selection(markets) do
    markets
    |> Enum.flat_map(fn market ->
      market.outcomes
      |> Enum.filter(&(&1.conflict != true))
      |> Enum.map(&{market.id, market.specifiers, &1.id})
    end)
    |> Enum.random()
  end
end

# configure :uof_api
base_url = System.fetch_env!("UOF_BASE_URL")
auth_token = System.fetch_env!("UOF_AUTH_TOKEN")

:ok = Application.put_env(:uof_api, :base_url, base_url)
:ok = Application.put_env(:uof_api, :auth_token, auth_token)

# disable debug logs
Logger.configure(level: :info)

acca_length = 3

fixtures =
  UOF.API.Sports.fixtures(
    &(&1.tournament.sport.name in ["Basketball", "Soccer"] &&
        &1.liveodds != "not_available" &&
        &1.status != "ended"),
    & &1.id
  )

fixture =
  fixtures
  |> Enum.shuffle()
  |> Enum.find(fn fixture ->
    {:ok, available} = UOF.API.CustomBet.available_selections(fixture)
    Enum.count(available.markets) >= acca_length
  end)

acca = Utils.build(fixture, acca_length)
```