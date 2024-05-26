defmodule UOF.API.Fixtures.Test do
  use ExUnit.Case

  setup do
    :ok = Application.put_env(:tesla, UOF.API, adapter: Tesla.Mock)

    Tesla.Mock.mock(fn
      %{method: :get} ->
        resp = File.read!("test/data/fixture.xml")
        %Tesla.Env{status: 200, headers: [{"content-type", "application/xml"}], body: resp}
    end)

    :ok
  end

  test "can parse UOF.API.Fixtures.show/{1, 2} response" do
    {:ok, fixture} = UOF.API.Fixtures.show("sr:match:8696826")

    # fixture attributes
    assert fixture.start_time_confirmed == true
    assert fixture.liveodds == "not_available"
    assert fixture.status == "closed"
    assert fixture.next_live_time == "2016-10-31T18:00:00+00:00"
    assert fixture.id == "sr:match:8696826"
    assert fixture.scheduled == "2016-10-31T18:00:00+00:00"
    assert fixture.start_time_tbd == false
    # tournament round
    assert fixture.tournament_round.type == "group"
    assert fixture.tournament_round.number == "25"
    assert fixture.tournament_round.group_long_name == "Ettan, Sodra"
    assert fixture.tournament_round.betradar_name == "Ettan, Sodra"
    assert fixture.tournament_round.betradar_id == 4301
    # season
    assert fixture.season.start_date == "2016-04-16"
    assert fixture.season.end_date == "2016-11-05"
    assert fixture.season.year == "2016"
    assert fixture.season.tournament_id == "sr:tournament:68"
    assert fixture.season.id == "sr:season:12346"
    assert fixture.season.name == "Div 1, Sodra 2016"
    # tournament
    assert fixture.tournament.id == "sr:tournament:68"
    assert fixture.tournament.name == "Ettan, Sodra"
    assert fixture.tournament.sport.id == "sr:sport:1"
    assert fixture.tournament.sport.name == "Soccer"
    assert fixture.tournament.category.id == "sr:category:9"
    assert fixture.tournament.category.name == "Sweden"
    # competitors
    [competitor1, competitor2] = fixture.competitors
    assert competitor1.qualifier == "home"
    assert competitor1.id == "sr:competitor:1860"
    assert competitor1.name == "IK Oddevold"
    assert competitor1.abbreviation == "ODD"
    assert competitor1.short_name == "Oddevold"
    assert competitor1.country == "Sweden"
    assert competitor1.country_code == "SWE"
    assert competitor1.gender == "male"
    assert competitor2.qualifier == "away"
    assert competitor2.id == "sr:competitor:22356"
    assert competitor2.name == "Tvaakers IF"
    assert competitor2.abbreviation == "TVA"
    assert competitor2.short_name == "Tvaakers"
    assert competitor2.country == "Sweden"
    assert competitor2.country_code == "SWE"
    assert competitor2.gender == "male"
    # tv channels
    # assert fixture.tv_channels == []
    # extra info
    [info1, info2, info3, info4, info5, info6, info7] = fixture.extra_info
    assert info1.key == "RTS"
    assert info1.value == "not_available"
    assert info2.key == "coverage_source"
    assert info2.value == "venue"
    assert info3.key == "extended_live_markets_offered"
    assert info3.value == "false"
    assert info4.key == "streaming"
    assert info4.value == "false"
    assert info5.key == "auto_traded"
    assert info5.value == "false"
    assert info6.key == "neutral_ground"
    assert info6.value == "false"
    assert info7.key == "period_length"
    assert info7.value == "45"
    # product info
    # TO-DO: implement
    # reference ids
    [reference] = fixture.reference_ids
    assert reference.name == "BetradarCtrl"
    assert reference.value == "11428313"
  end
end
