# Betradar's Unified Odds Feed (UOF) HTTP API

[![CI](https://github.com/efcasado/uof_api/actions/workflows/elixir.yml/badge.svg)](https://github.com/efcasado/uof_api/actions/workflows/elixir.yml)
[![Package Version](https://img.shields.io/hexpm/v/uof_api.svg)](https://hex.pm/packages/uof_api)
[![hexdocs.pm](https://img.shields.io/badge/hex-docs-purple.svg)](https://hexdocs.pm/uof_api/)

> [!IMPORTANT]
> This is an **unofficial client** for Betradar's Unified Odds Feed (UOF) HTTP API.
> Betradar offers official Java and .NET SDKs. You can read more about these
> [here](https://sdk.sportradar.com).

Elixir client for Betradar's Unified Odds Feed (UOF) HTTP API.

It covers the documented HTTP API surface across these modules:

| Module | API |
| --- | --- |
| `UOF.API.Sports` | Schedules and fixtures, fixture/result changes, summaries, timelines, sports, tournaments, seasons, categories, and player/competitor/venue profiles |
| `UOF.API.Descriptions` | Betting descriptions: markets, variants, producers, match/betting statuses, betstop/void reasons |
| `UOF.API.Probability` | Sport-event probabilities (cashout) |
| `UOF.API.CustomBet` | Available selections and odds/probability calculation |
| `UOF.API.Recovery` | Odds and stateful-message recovery |
| `UOF.API.Booking` | Booking events for live odds |
| `UOF.API.Users` | Token / bookmaker information |

Responses are parsed into [Ecto](https://hexdocs.pm/ecto) embedded schemas under
`UOF.API.Schemas.*`, generated from Betradar's official XSDs (see
[Regenerating the schemas](#regenerating-the-schemas)). The structs mirror the
XSD nesting faithfully, so lists are wrapped (e.g. `competitors.competitor`) and
field types follow the XSD (dates/datetimes are cast, odds/probabilities are
`Decimal`, and some feed values such as scores are strings).


## Get Started

### Configuration

To be able to interact with Betradar's API, you first need to configure a valid
`authentication token` and the `base url` of the Betradar environment you want
to use.

```elixir
:ok = Application.put_env(:uof_api, :base_url, "<betradar-uof-base-url>")
:ok = Application.put_env(:uof_api, :auth_token, "<betradar-uof-auth-token>")
```

### Usage

Stream all available fixtures. Pagination over the prematch schedule is handled
for you, and pages are fetched lazily so the stream composes with `Stream`/`Enum`
and supports early termination.

```elixir
UOF.API.Sports.Fixtures.stream()
|> Enum.count()
# => 51591
```

Compose `Stream` operations to narrow the catalogue down without loading it all
into memory — for example, all events currently bookable for live odds:

```elixir
UOF.API.Sports.Fixtures.stream()
|> Stream.filter(&(&1.liveodds == "bookable"))
|> Enum.to_list()
```

Aggregating over the streamed events works as you would expect:

```elixir
UOF.API.Sports.Fixtures.stream()
|> Stream.map(& &1.tournament.sport.name)
|> Enum.uniq()
# => ["Soccer", "Handball", "Basketball", ...]
```

Fetch the details of a single fixture:

```elixir
{:ok, %{fixture: fixture}} = UOF.API.Sports.fixture("sr:match:8696826")
# =>
# %UOF.API.Schemas.Sports.Fixture{
#   id: "sr:match:8696826",
#   status: "closed",
#   liveodds: "not_available",
#   scheduled: ~U[2016-10-31 18:00:00Z],
#   tournament: %UOF.API.Schemas.Sports.Tournament{
#     name: "Ettan, Sodra",
#     sport: %UOF.API.Schemas.Sports.Sport{name: "Soccer", ...},
#     ...
#   },
#   season: %UOF.API.Schemas.Sports.SeasonExtended{
#     name: "Div 1, Sodra 2016",
#     start_date: ~D[2016-04-16],
#     ...
#   },
#   competitors: %UOF.API.Schemas.Sports.SportEventCompetitors{
#     competitor: [
#       %UOF.API.Schemas.Sports.TeamCompetitor{id: "sr:competitor:1860", name: "IK Oddevold", qualifier: "home", ...},
#       %UOF.API.Schemas.Sports.TeamCompetitor{id: "sr:competitor:22356", name: "Tvaakers IF", qualifier: "away", ...}
#     ]
#   },
#   ...
# }
```

Fetch an entity profile (note the faithful nesting — `jerseys.jersey`,
`players.player`):

```elixir
{:ok, profile} = UOF.API.Sports.competitor("sr:competitor:2672")
# =>
# %UOF.API.Schemas.Sports.CompetitorProfileEndpoint{
#   competitor: %UOF.API.Schemas.Sports.TeamExtended{name: "Bayern Munich", ...},
#   venue:   %UOF.API.Schemas.Sports.Venue{name: "Allianz Arena", capacity: 75000, ...},
#   jerseys: %UOF.API.Schemas.Sports.Jerseys{jersey: [...]},   # 4
#   players: %UOF.API.Schemas.Sports.Players{player: [...]},   # 32
#   ...
# }
```

Betting descriptions:

```elixir
{:ok, %{market: markets}} = UOF.API.Descriptions.markets()
{:ok, %{producer: producers}} = UOF.API.Descriptions.producers()
```

Custom bet lets you combine markets across fixtures into a single accumulator.
First list the markets available for a fixture:

```elixir
{:ok, available} = UOF.API.CustomBet.available_selections("sr:match:42795059")

market = hd(available.markets)
outcome = hd(market.outcomes)
# a selection is a {fixture_id, market_id, outcome_id} tuple
{"sr:match:42795059", market.id, outcome.id}
```

Then calculate the combined odds and probability for a list of selections:

```elixir
{:ok, calculation} = UOF.API.CustomBet.calculate([
  {"sr:match:42795059", 97, 74},
  {"sr:match:42795059", 10, 9}
])
# calculation.calculation.odds        => #Decimal<5.22>
# calculation.calculation.probability => #Decimal<0.15>
```

Pass `true` as the second argument to `calculate/2` to also get back the further
markets that can still be added to the bet.

Probabilities (cashout):

```elixir
{:ok, cashout} = UOF.API.Probability.probabilities("sr:match:41878167")
```

Booking. There are no booking-calendar `GET` endpoints; booking state is read
from a schedule via the `liveodds` attribute:

```elixir
{:ok, _ack} = UOF.API.Booking.book("sr:match:12345")

{:ok, schedule} = UOF.API.Sports.schedule("2024-12-01")
UOF.API.Sports.Fixtures.bookable(schedule)
# also: booked/1, buyable/1, with_liveodds/2
```

Odds recovery (the recovered messages arrive over the AMQP feed; the HTTP call
returns an acknowledgement):

```elixir
{:ok, _ack} = UOF.API.Recovery.recover("liveodds", request_id: 1, after: 1_700_000_000_000)
{:ok, _ack} = UOF.API.Recovery.recover_event("liveodds", "sr:match:12345", request_id: 2)
```


## Regenerating the schemas

The Ecto schemas under `lib/uof/api/schemas/` are generated from Betradar's
XSDs. The XSDs are downloaded on demand (pinned to an upstream SDK tag) into the
git-ignored `priv/xsd/` cache:

```
mix uof.xsd.fetch     # download the XSDs
mix uof.gen.schemas   # generate the schemas
```


## Contributing

This project uses [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/).

The list of supported commit types can be found [here](https://github.com/insurgent-lab/conventional-changelog-preset?tab=readme-ov-file#commit-types).
