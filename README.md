![UOF API](https://github.com/efcasado/uof_api/raw/main/assets/readme_logo.png)

[![Build Status](https://github.com/efcasado/uof_api/actions/workflows/elixir.yml/badge.svg?branch=main)](https://github.com/efcasado/uof_api/actions)
[![Package Version](https://img.shields.io/hexpm/v/uof_api.svg)](https://hex.pm/packages/uof_api)


# UOF API

> [!IMPORTANT]
> This is an **unofficial client** for Betradar's Unified Odds Feed (UOF) HTTP API.
> Betradar offers official Java and .NET SDKs. You can read more about these
> [here](https://sdk.sportradar.com).

Elixir client for Betradar's Unified Odds Feed (UOF) HTTP API.

This project implements Betradar's Custom Bet, Probability, Recovery and Sports
APIs, which can be found in the `UOF.API.{CustomBet, Probability, Recovery,
Sports}` modules, respectively.


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

Fetch all available fixtures.

```elixir
fixtures = UOF.API.Sports.fixtures
```

Given a list fixtures, count how many of them there are.

```elixir
Enum.count(fixtures)
# => 51591
```

Or inspect a random fixture from the list.

```elixir
fixture = Enum.random(fixtures)
# =>
# %UOF.API.Mappings.SportEvent{
#   liveodds: nil,
#   status: "not_started",
#   next_live_time: nil,
#   id: "sr:match:46657257",
#   scheduled: "2024-12-01T23:00:00+00:00",
#   start_time_tbd: true,
#   venue: %UOF.API.Mappings.Venue{
#     id: "sr:venue:69401",
#     name: "Estadio Claudio Chiqui Tapia",
#     capacity: 4400,
#     city_name: "Barracas",
#     country_name: "Argentina",
#     map_coordinates: "-34.646901,-58.396364",
#     country_code: "ARG"
#   },
#   season: %UOF.API.Mappings.Season{
#     id: "sr:season:114317",
#     name: "Liga Profesional 2024",
#     start_date: "2024-05-04",
#     end_date: "2024-12-16",
#     year: "2024",
#     tournament_id: "sr:tournament:155"
#   },
#   tournament_round: %UOF.API.Mappings.TournamentRound{
#     betradar_id: 68,
#     betradar_name: nil,
#     type: "group",
#     name: nil,
#     cup_round_matches: nil,
#     cup_round_match_number: nil,
#     other_match_id: nil,
#     number: "25",
#     group: nil,
#     group_id: nil,
#     group_long_name: "Liga Profesional",
#     phase: "regular season"
#   },
#   tournament: %UOF.API.Mappings.Tournament{
#     id: "sr:tournament:155",
#     name: "Liga Profesional",
#     current_season: nil,
#     season_coverage: nil,
#     sport: %UOF.API.Mappings.Sport{id: "sr:sport:1", name: "Soccer"},
#     category: %UOF.API.Mappings.Category{
#       id: "sr:category:48",
#       name: "Argentina",
#       country_code: "ARG"
#     }
#   },
#   competitors: [
#     %UOF.API.Mappings.Competitor{
#       id: "sr:competitor:65668",
#       name: "Barracas Central",
#       state: nil,
#       country: "Argentina",
#       country_code: "ARG",
#       abbreviation: "BAR",
#       qualifier: "home",
#       virtual: nil,
#       gender: "male",
#       short_name: "Barracas",
#       sport: nil,
#       category: nil,
#       references: [
#         %UOF.API.Mappings.Reference{name: "betradar", value: "17080628"}
#       ]
#     },
#     %UOF.API.Mappings.Competitor{
#       id: "sr:competitor:7628",
#       name: "CA Tigre",
#       state: nil,
#       country: "Argentina",
#       country_code: "ARG",
#       abbreviation: "TIG",
#       qualifier: "away",
#       virtual: nil,
#       gender: "male",
#       short_name: "Tigre",
#       sport: nil,
#       category: nil,
#       references: [
#         %UOF.API.Mappings.Reference{name: "betradar", value: "1048782"}
#       ]
#     }
#   ]
# }
```

We can also list of the different statuses reported by all the currently
available fixtures

```elixir
fixtures
|> Enum.map(&(&1.status))
|> Enum.uniq
# => ["not_started", "cancelled", "postponed", "closed"]
```

Similarly, we can easily get a list of the different sports the currently
available fixtures belong to

```elixir
fixtures
|> Enum.map(&(&1.tournament.sport.name))
|> Enum.uniq
# =>
# [
#   "Soccer",
#   "Handball",
#   "American Football",
#   "Rugby",
#   "Basketball",
#   "Volleyball",
#   "Cricket",
#   "Baseball",
#   "Table Tennis",
#   "Tennis",
#   "Futsal",
#   "Aussie Rules",
#   "Ice Hockey",
#   "Speedway",
#   "Field hockey",
#   "Waterpolo",
#   "Pesapallo",
#   "Boxing",
#   "MMA",
#   "Bowls",
#   "ESport Call of Duty",
#   "Gaelic Hurling",
#   "Darts",
#   "ESport Counter-Strike",
#   "Rink Hockey",
#   "ESport Arena of Valor",
#   "Basketball 3x3",
#   "Lacrosse",
#   "ESport King of Glory",
#   "Gaelic Football",
#   "ESport League of Legends",
#   "Squash",
#   "eSoccer",
#   "Snooker",
#   "ESport Dota",
#   "Cycling"
# ]
```

Or, count how many fixtures there are for each sport

```elixir
fixtures
|> Enum.reduce(%{}, fn(f, acc) -> Map.update(acc, f.tournament.sport.name, 1, &(&1 + 1)) end)
# =>
# %{
#   "Handball" => 776,
#   "Basketball" => 2832,
#   "Cricket" => 673,
#   "Speedway" => 133,
#   "ESport Call of Duty" => 50,
#   "Futsal" => 383,
#   "Boxing" => 65,
#   "Gaelic Football" => 2,
#   "Waterpolo" => 67,
#   "Rugby" => 1168,
#   "Gaelic Hurling" => 19,
#   "Baseball" => 13428,
#   "Darts" => 70,
#   "Soccer" => 26913,
#   "MMA" => 102,
#   "Table Tennis" => 535,
#   "Lacrosse" => 9,
#   "Tennis" => 751,
#   "Ice Hockey" => 300,
#   "eSoccer" => 492,
#   "Cycling" => 32,
#   "ESport Counter-Strike" => 99,
#   "ESport Arena of Valor" => 1,
#   "Squash" => 75,
#   "ESport King of Glory" => 7,
#   "Field hockey" => 152,
#   "Pesapallo" => 433,
#   "Bowls" => 130,
#   "Rink Hockey" => 8,
#   "ESport League of Legends" => 4,
#   "ESport Dota" => 4,
#   "Basketball 3x3" => 48,
#   "American Football" => 1172,
#   "Snooker" => 4,
#   "Aussie Rules" => 265,
#   "Volleyball" => 389
# }
```

When we fetch the list of all available fixtures, we only get limited
information for each of the returned fixtures. We can use other available
function to retrieve more details.

The example below illustrates how much more information there is available
about the teams competing in a football game.

```elixir
fixture = Enum.random(fixtures)
competitor = Enum.random(fixture.competitors)
{:ok, competitor} = UOF.API.Sports.competitor(competitor.id)
# =>
# {:ok,
#  %UOF.API.Mappings.CompetitorProfile{
#    competitor: %UOF.API.Mappings.Competitor{
#      id: "sr:competitor:65668",
#      name: "Barracas Central",
#      state: nil,
#      country: "Argentina",
#      country_code: "ARG",
#      abbreviation: "BAR",
#      qualifier: nil,
#      virtual: nil,
#      gender: "male",
#      short_name: "Barracas",
#      sport: %UOF.API.Mappings.Sport{id: "sr:sport:1", name: "Soccer"},
#      category: %UOF.API.Mappings.Category{
#        id: "sr:category:48",
#        name: "Argentina",
#        country_code: "ARG"
#      },
#      references: []
#    },
#    venue: %UOF.API.Mappings.Venue{
#      id: "sr:venue:69401",
#      name: "Estadio Claudio Chiqui Tapia",
#      capacity: 4400,
#      city_name: "Barracas",
#      country_name: "Argentina",
#      map_coordinates: "-34.646901,-58.396364",
#      country_code: "ARG"
#    },
#    manager: %UOF.API.Mappings.Manager{
#      id: "sr:player:1989503",
#      name: "Orfila, Alejandro",
#      nationality: "Uruguay",
#      country_code: "URY"
#    },
#    jerseys: [
#      %UOF.API.Mappings.Jersey{
#        type: "home",
#        base: "ffffff",
#        sleeve: "ff0000",
#        number: "cf0d04",
#        stripes: true,
#        horizontal_stripes: false,
#        squares: false,
#        split: false,
#        shirt_type: "short_sleeves"
#      },
#      %UOF.API.Mappings.Jersey{
#        type: "away",
#        base: "1f242f",
#        sleeve: "ffffff",
#        number: "c2880b",
#        stripes: false,
#        horizontal_stripes: false,
#        squares: false,
#        split: false,
#        shirt_type: "short_sleeves"
#      },
#      %UOF.API.Mappings.Jersey{
#        type: "goalkeeper",
#        base: "d91c7e",
#        sleeve: "000000",
#        number: "000000",
#        stripes: false,
#        horizontal_stripes: false,
#        squares: false,
#        split: false,
#        shirt_type: "short_sleeves"
#      },
#      %UOF.API.Mappings.Jersey{
#        type: "third",
#        base: "c60000",
#        sleeve: "ffffff",
#        number: "d5b225",
#        stripes: false,
#        horizontal_stripes: false,
#        squares: true,
#        split: false,
#        shirt_type: "short_sleeves"
#      }
#    ],
#    players: [
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "1998-01-30",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 179,
#        weight: nil,
#        jersey_number: nil,
#        full_name: "Lucas Lopez",
#        gender: "male",
#        id: "sr:player:2227176",
#        name: "López, Lucas"
#      },
#      %UOF.API.Mappings.Player{
#        type: "goalkeeper",
#        date_of_birth: "2000-04-30",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 186,
#        weight: nil,
#        jersey_number: nil,
#        full_name: "Rafael Ferrario",
#        gender: "male",
#        id: "sr:player:1713131",
#        name: "Ferrario, Rafael"
#      },
#      %UOF.API.Mappings.Player{
#        type: "defender",
#        date_of_birth: "1998-03-03",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 183,
#        weight: 73,
#        jersey_number: 2,
#        full_name: "Nicolas Capraro",
#        gender: "male",
#        id: "sr:player:2539015",
#        name: "Capraro, Nicolas"
#      },
#      # truncated to improve readability
#      # (...)
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2000-09-18",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 175,
#        weight: nil,
#        jersey_number: 79,
#        full_name: "Maximiliano Andres Puig",
#        gender: "male",
#        id: "sr:player:2296877",
#        name: "Puig, Maximiliano"
#      }
#    ]
#  }}
```