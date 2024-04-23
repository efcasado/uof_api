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
UOF.API.sports

# %{
#  sports: [
#    %{id: "sr:sport:143", name: "7BallRun"},
#    %{id: "sr:sport:192", name: "Air Racing"},
#    %{id: "sr:sport:43", name: "Alpine Skiing"},
#    ...
#    ]
# }
```