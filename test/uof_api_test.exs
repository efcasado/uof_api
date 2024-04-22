defmodule UofApiTest do
  use ExUnit.Case

  doctest UOF.API

  test "should parse all available tournaments" do
    {:ok, %UOF.API.Mappings.Tournaments{tournaments: tournaments}} = UOF.API.tournaments()
    # sample 10% of all available tournaments
    tournaments = sample(tournaments, 10)
    Enum.each(tournaments, &UOF.API.tournament(&1.id))
  end

  test "should parse all available pre-match fixtures" do
    {:ok, %UOF.API.Mappings.Schedule{events: fixtures}} = UOF.API.schedule("pre")
    # sample 10% of all available fixtures
    fixtures = sample(fixtures, 10)
    Enum.each(fixtures, &UOF.API.fixture(&1.id))
  end

  test "should parse all available live fixtures" do
    {:ok, %UOF.API.Mappings.Schedule{events: fixtures}} = UOF.API.schedule("live")
    # sample 10% of all available fixtures
    fixtures = sample(fixtures, 10)
    Enum.each(fixtures, &UOF.API.fixture(&1.id))
  end

  def sample(xs, percent) do
    n = div(Enum.count(xs), percent)

    Enum.take(Enum.shuffle(xs), n)
  end
end
