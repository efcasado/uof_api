![UOF API](https://github.com/efcasado/uof_api/raw/main/assets/readme_logo.png)

# UOF API

Elixir client for Betradar's Unified Odds Feed (UOF) HTTP API.

The list of all available endpoints can be found
[here](https://docs.betradar.com/display/BD/UOF+-+List+of+End+Points).

> [!IMPORTANT]
> This is an **unofficial client** for Betradar's Unified Odds Feed (UOF) HTTP API.
> At the time of this writing, Betradar offers Java and .NET SDKs. You can read
> more about Betradar's official SDKs [here](https://sdk.sportradar.com).



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