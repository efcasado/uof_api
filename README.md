![UOF API](https://github.com/efcasado/uof_api/raw/main/assets/readme_logo.png)

[![Build Status](https://github.com/efcasado/uof_api/actions/workflows/elixir.yml/badge.svg?branch=main)](https://github.com/efcasado/uof_api/actions)

# UOF API

Elixir client for Betradar's Unified Odds Feed (UOF) HTTP API.

> [!IMPORTANT]
> This is an **unofficial client** for Betradar's Unified Odds Feed (UOF) HTTP API.
> Betradar offers official Java and .NET SDKs. You can read more about these
> [here](https://sdk.sportradar.com).


### Get Started

```elixir
config :uof_api, base_url: "<betradar-uof-base-url>"
config :uof_api, auth_token: "<your-auth-token>"
```

```elixir
# Get all available sports
{:ok, %UOF.API.Mappings.Sports{sports: sports}} = UOF.API.sports
# ...
football = Enum.find(sports, &(&1.name == "Soccer"))

# Get all available tournaments
{:ok, %UOF.API.Mappings.Tournaments{tournaments: tournaments}} = UOF.API.tournaments
# Get all football tournaments
football_tournaments = Enum.filter(tournaments, &(&1.sport == football))
```