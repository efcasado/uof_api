defmodule UOF.API.Schemas.Probability.SportEventStatus do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:status, :integer)
    field(:reporting, :integer)
    field(:match_status, :integer)
    field(:home_score, :decimal)
    field(:away_score, :decimal)
    field(:home_penalty_score, :integer)
    field(:away_penalty_score, :integer)
    field(:home_gamescore, :integer)
    field(:away_gamescore, :integer)
    field(:home_legscore, :integer)
    field(:away_legscore, :integer)
    field(:current_server, :integer)
    field(:expedite_mode, :boolean)
    field(:tiebreak, :boolean)
    field(:home_suspend, :integer)
    field(:away_suspend, :integer)
    field(:balls, :integer)
    field(:strikes, :integer)
    field(:outs, :integer)
    field(:bases, :string)
    field(:home_batter, :integer)
    field(:away_batter, :integer)
    field(:pitcher, :string)
    field(:batter, :string)
    field(:pitch_count, :integer)
    field(:pitches_seen, :integer)
    field(:total_hits, :integer)
    field(:total_pitches, :integer)
    field(:possession, :integer)
    field(:position, :integer)
    field(:try, :integer)
    field(:yards, :integer)
    field(:throw, :integer)
    field(:visit, :integer)
    field(:remaining_reds, :integer)
    field(:delivery, :integer)
    field(:home_remaining_bowls, :integer)
    field(:away_remaining_bowls, :integer)
    field(:current_end, :integer)
    field(:innings, :integer)
    field(:over, :integer)
    field(:home_penalty_runs, :integer)
    field(:away_penalty_runs, :integer)
    field(:home_dismissals, :integer)
    field(:away_dismissals, :integer)
    field(:current_ct_team, :integer)
    field(:period_of_leader, :integer)
    field(:home_drive_count, :integer)
    field(:away_drive_count, :integer)
    field(:home_play_count, :integer)
    field(:away_play_count, :integer)
    embeds_one(:clock, UOF.API.Schemas.Probability.Clock)
    embeds_one(:period_scores, UOF.API.Schemas.Probability.Periodscores)
    embeds_one(:results, UOF.API.Schemas.Probability.Results)
    embeds_one(:statistics, UOF.API.Schemas.Probability.Statistics)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [
      :status,
      :reporting,
      :match_status,
      :home_score,
      :away_score,
      :home_penalty_score,
      :away_penalty_score,
      :home_gamescore,
      :away_gamescore,
      :home_legscore,
      :away_legscore,
      :current_server,
      :expedite_mode,
      :tiebreak,
      :home_suspend,
      :away_suspend,
      :balls,
      :strikes,
      :outs,
      :bases,
      :home_batter,
      :away_batter,
      :pitcher,
      :batter,
      :pitch_count,
      :pitches_seen,
      :total_hits,
      :total_pitches,
      :possession,
      :position,
      :try,
      :yards,
      :throw,
      :visit,
      :remaining_reds,
      :delivery,
      :home_remaining_bowls,
      :away_remaining_bowls,
      :current_end,
      :innings,
      :over,
      :home_penalty_runs,
      :away_penalty_runs,
      :home_dismissals,
      :away_dismissals,
      :current_ct_team,
      :period_of_leader,
      :home_drive_count,
      :away_drive_count,
      :home_play_count,
      :away_play_count
    ])
    |> cast_embed(:clock)
    |> cast_embed(:period_scores)
    |> cast_embed(:results)
    |> cast_embed(:statistics)
  end
end
