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

{odds, prob, sels} = Utils.build(fixture, acca_length)
sels = Enum.map(sels, fn {_, mid, oid, mspecs} -> {mid, mspecs, oid} end)

IO.puts("[#{acca_length}-fold accumulator @ #{fixture}]")
IO.puts("odds = #{odds}")
IO.puts("probability = #{prob}")
IO.puts("selections = #{inspect(sels)}")
