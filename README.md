![UOF API](https://github.com/efcasado/uof_api/raw/main/assets/readme_logo.png)

# UOF API

Elixir client for Betradar's Unified Odds Feed (UOF) HTTP API.


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