# https://docs.betradar.com/display/BD/Tournament_round
defmodule UOF.API.TournamentRound do
  @moduledoc """
  """
  import SweetXml

  defstruct betradar_id: "",
    betradar_name: "",
    type: "",
    name: "",
    cup_round_matches: 0,
    cup_round_match_number: 0,
    other_match_id: "",
    number: "",
    group: "",
    group_id: "",
    group_long_name: "",
    phase: ""

  @type t :: %__MODULE__{
    betradar_id: String.t,
    betradar_name: String.t,
    type: String.t,
    name: Stirng.t,
    cup_round_matches: non_neg_integer,
    cup_round_match_number: non_neg_integer,
    other_match_id: String.t,
    number: String.t,
    group: String.t,
    group_id: String.t,
    group_long_name: String.t,
    phase: String.t
  }

  def schema do
    [
      betradar_id: ~x"./@betradar_id"i,
      betradar_name: ~x"./@betradar_name"s,
      type: ~x"./@type"s,
      # cup
      name: ~x"./@name"os,
      cup_round_matches: ~x"./@cup_round_matches"oi,
      cup_round_match_number: ~x"./@cup_round_match_number"oi,
      other_match_id: ~x"./@other_match_id"os,
      # group
      number: ~x"./@number"os,
      group: ~x"./@group"os,
      group_id: ~x"./@group_id"os,
      group_long_name: ~x"./@group_long_name"os,
      # qualification
      # ???
      phase: ~x"./@phase"os
    ]
  end
end
