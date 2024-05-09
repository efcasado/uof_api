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

```elixir
# configuration
:ok = Application.put_env(:uof_api, :base_url, "<betradar-uof-base-url>")
:ok = Application.put_env(:uof_api, :auth_token, "<betradar-uof-base-url>")

fixtures = UOF.API.Sports.fixtures

Enum.count(fixtures)
# 51591

hd(fixtures)
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

fixtures
|> Enum.map(&(&1.status))
|> Enum.uniq
# ["not_started", "cancelled", "postponed", "closed"]

fixtures
|> Enum.map(&(&1.tournament.sport.name))
|> Enum.uniq
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

fixtures
|> Enum.reduce(%{}, fn(f, acc) -> Map.update(acc, f.tournament.sport.name, 1, &(&1 + 1)) end)
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

hd(hd(fixtures).competitors)
# %UOF.API.Mappings.Competitor{
#   id: "sr:competitor:65668",
#   name: "Barracas Central",
#   state: nil,
#   country: "Argentina",
#   country_code: "ARG",
#   abbreviation: "BAR",
#   qualifier: "home",
#   virtual: nil,
#   gender: "male",
#   short_name: "Barracas",
#   sport: nil,
#   category: nil,
#   references: [%UOF.API.Mappings.Reference{name: "betradar", value: "17080628"}]
# }

UOF.API.Sports.competitor(hd(hd(fixtures).competitors).id)
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
#      %UOF.API.Mappings.Player{
#        type: "defender",
#        date_of_birth: "2001-05-31",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 176,
#        weight: nil,
#        jersey_number: 3,
#        full_name: "Franco Nicolas Tolosa",
#        gender: "male",
#        id: "sr:player:2342547",
#        name: "Tolosa, Franco Nicolas"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2001-08-28",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 181,
#        weight: nil,
#        jersey_number: 4,
#        full_name: "Pedro Agustin Velurtas",
#        gender: "male",
#        id: "sr:player:2254161",
#        name: "Velurtas, Pedro"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2000-08-02",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 181,
#        weight: 76,
#        jersey_number: 5,
#        full_name: "Rodrigo Ezequiel Herrera",
#        gender: "male",
#        id: "sr:player:2083425",
#        name: "Herrera, Rodrigo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "1997-12-16",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 179,
#        weight: 76,
#        jersey_number: 6,
#        full_name: "Rodrigo Axel Insua",
#        gender: "male",
#        id: "sr:player:2109216",
#        name: "Insua, Rodrigo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2000-06-07",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 177,
#        weight: nil,
#        jersey_number: 8,
#        full_name: "Siro Ignacio Cabral Rosane",
#        gender: "male",
#        id: "sr:player:2098302",
#        name: "Rosane, Siro"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "1991-12-11",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 174,
#        weight: 70,
#        jersey_number: 8,
#        full_name: "Matias Alejandro Laba",
#        gender: "male",
#        id: "sr:player:146950",
#        name: "Laba, Matias"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "1996-10-30",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 185,
#        weight: 84,
#        jersey_number: 9,
#        full_name: "Alexis Andres Dominguez Ansorena",
#        gender: "male",
#        id: "sr:player:1131875",
#        name: "Dominguez, Alexis"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "1998-06-28",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 184,
#        weight: nil,
#        jersey_number: 11,
#        full_name: "Alan Martin Cantero",
#        gender: "male",
#        id: "sr:player:2089567",
#        name: "Cantero, Alan"
#      },
#      %UOF.API.Mappings.Player{
#        type: "defender",
#        date_of_birth: "1998-08-16",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 184,
#        weight: 79,
#        jersey_number: 14,
#        full_name: "Marcos Gonzalo Goni",
#        gender: "male",
#        id: "sr:player:1103783",
#        name: "Goni, Gonzalo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "defender",
#        date_of_birth: "1999-11-04",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 187,
#        weight: nil,
#        jersey_number: 15,
#        full_name: "Nicolas Demartini",
#        gender: "male",
#        id: "sr:player:2136340",
#        name: "Demartini, Nicolas"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "1989-10-14",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 177,
#        weight: 93,
#        jersey_number: 17,
#        full_name: "Ramon Dario Abila",
#        gender: "male",
#        id: "sr:player:798660",
#        name: "Abila, Ramon"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "1990-09-16",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 169,
#        weight: 70,
#        jersey_number: 19,
#        full_name: "Carlos Alfredo Arce",
#        gender: "male",
#        id: "sr:player:2218880",
#        name: "Arce, Carlos Alfredo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "1995-03-15",
#        nationality: "Uruguay",
#        country_code: "URY",
#        height: 171,
#        weight: 63,
#        jersey_number: 20,
#        full_name: "Jhonatan Marcelo Candia Hernandez",
#        gender: "male",
#        id: "sr:player:1121379",
#        name: "Candia, Jhonatan"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "1999-01-23",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 172,
#        weight: nil,
#        jersey_number: 21,
#        full_name: "Lucas Emanuel Brochero",
#        gender: "male",
#        id: "sr:player:2091333",
#        name: "Brochero, Lucas"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2000-12-10",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 174,
#        weight: nil,
#        jersey_number: 22,
#        full_name: "Bahiano Benjamin Garcia",
#        gender: "male",
#        id: "sr:player:2754743",
#        name: "Garcia, Bahiano Benjamin"
#      },
#      %UOF.API.Mappings.Player{
#        type: "defender",
#        date_of_birth: "1997-02-11",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: nil,
#        weight: nil,
#        jersey_number: 23,
#        full_name: "Lucas Faggioli",
#        gender: "male",
#        id: "sr:player:2317417",
#        name: "Faggioli, Lucas"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2001-08-23",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 171,
#        weight: 71,
#        jersey_number: 24,
#        full_name: "Manuel Agustin Duarte",
#        gender: "male",
#        id: "sr:player:2148716",
#        name: "Duarte, Manuel"
#      },
#      %UOF.API.Mappings.Player{
#        type: "goalkeeper",
#        date_of_birth: "1990-08-26",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 188,
#        weight: 78,
#        jersey_number: 25,
#        full_name: "Sebastian Emanuel Moyano",
#        gender: "male",
#        id: "sr:player:147578",
#        name: "Moyano, Sebastian"
#      },
#      %UOF.API.Mappings.Player{
#        type: "defender",
#        date_of_birth: "1999-11-16",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: nil,
#        weight: nil,
#        jersey_number: 26,
#        full_name: "Agustin Irazoque",
#        gender: "male",
#        id: "sr:player:2220158",
#        name: "Irazoque, Agustin"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "1999-12-27",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 172,
#        weight: nil,
#        jersey_number: 27,
#        full_name: "Marcos Iacobellis",
#        gender: "male",
#        id: "sr:player:2108256",
#        name: "Iacobellis, Marcos"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "2001-07-30",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 180,
#        weight: nil,
#        jersey_number: 29,
#        full_name: "Daniel Eduardo Juarez",
#        gender: "male",
#        id: "sr:player:2091259",
#        name: "Juarez, Daniel Eduardo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "goalkeeper",
#        date_of_birth: "1997-08-21",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 186,
#        weight: 72,
#        jersey_number: 30,
#        full_name: "Marcelo Agustin Mino",
#        gender: "male",
#        id: "sr:player:1112861",
#        name: "Mino, Marcelo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "2000-07-12",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 170,
#        weight: 72,
#        jersey_number: 32,
#        full_name: "Santiago Agustin Coronel",
#        gender: "male",
#        id: "sr:player:2186238",
#        name: "Coronel, Santiago Agustin"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "1998-07-23",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 164,
#        weight: 64,
#        jersey_number: 33,
#        full_name: "Facundo Leonel Mater",
#        gender: "male",
#        id: "sr:player:2073027",
#        name: "Mater, Facundo"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2004-09-17",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: nil,
#        weight: nil,
#        jersey_number: 36,
#        full_name: "Alex Lionel Juarez",
#        gender: "male",
#        id: "sr:player:2374465",
#        name: "Juarez, Axel"
#      },
#      %UOF.API.Mappings.Player{
#        type: "midfielder",
#        date_of_birth: "2001-03-08",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 175,
#        weight: 72,
#        jersey_number: 43,
#        full_name: "Maximiliano Ezequiel Zalazar",
#        gender: "male",
#        id: "sr:player:2038795",
#        name: "Zalazar, Maximiliano"
#      },
#      %UOF.API.Mappings.Player{
#        type: "forward",
#        date_of_birth: "2002-04-22",
#        nationality: "Argentina",
#        country_code: "ARG",
#        height: 185,
#        weight: 83,
#        jersey_number: 48,
#        full_name: "Federico Aguirre",
#        gender: "male",
#        id: "sr:player:2563575",
#        name: "Aguirre, Federico"
#      },
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