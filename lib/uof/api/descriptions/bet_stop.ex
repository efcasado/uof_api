defmodule UOF.API.Descriptions.BetStop do
  @moduledoc """
  `BetStop` messages are used to indicate that all, or a set of markets should
  be instantly suspended (continue to display odds, but don't accept tickets).

  `BetStop` messages are sent very rapidly, as soon as a Betradar operator
  detects an issue. At the time the `BetStop` is sent, the cause is not always
  available (typically not for live matches). The cause of the `BetStop` is
  provided in a subsequent `OddsChange` message.
  """
  use Ecto.Schema
  import Ecto.Changeset
  import UOF.API.EctoHelpers

  @doc """
  List all supported bet stop reasons.
  """
  @spec all() :: list(BetStop.t())
  def all() do
    case UOF.API.get("/descriptions/betstop_reasons.xml") do
      {:ok, %_{status: 200, body: resp}} ->
        resp
        |> Map.get("betstop_reasons_descriptions")
        |> Map.get("betstop_reason")
        |> Enum.map(fn x ->
          {:ok, x} = changeset(x)
          x
        end)

      {:error, _} = error ->
        error
    end
  end

  @primary_key false

  embedded_schema do
    field(:id, :integer)

    field(:description, Ecto.Enum,
      values: [
        :UNKNOWN,
        :POSSIBLE_GOAL,
        :POSSIBLE_RED_CARD,
        :SCOUT_LOST,
        :POSSIBLE_GOAL_HOME,
        :POSSIBLE_GOAL_AWAY,
        :POSSIBLE_RED_CARD_HOME,
        :POSSIBLE_RED_CARD_AWAY,
        :POSSIBLE_PENALTY,
        :POSSIBLE_PENALTY_HOME,
        :POSSIBLE_PENALTY_AWAY,
        :CONNECTED_TO_SUPERVISOR,
        :MATCH_ENDED,
        :GAMEPOINT,
        :TIEBREAK,
        :POSSIBLE_DIRECT_FOUL_HOME,
        :POSSIBLE_DIRECT_FOUL_AWAY,
        :POSSIBLE_DIRECT_FOUL,
        :DANGEROUS_FREE_KICK_HOME,
        :DANGEROUS_FREE_KICK_AWAY,
        :DANGEROUS_GOAL_POSITION_HOME,
        :DANGEROUS_GOAL_POSITION_AWAY,
        :GOAL_UNDER_REVIEW,
        :SCORE_UNDER_REVIEW,
        :DISCONNECTION,
        :POSSIBLE_CHECKOUT,
        :MULTIPLE_SUSPENSIONS,
        :POSSIBLE_DANGEROUS_FREE_KICK,
        :POSSIBLE_DANGEROUS_GOAL_POSITION,
        :POSSIBLE_TOUCHDOWN_HOME,
        :POSSIBLE_TOUCHDOWN_AWAY,
        :POSSIBLE_FIELDGOAL_HOME,
        :POSSIBLE_FIELDGOAL_AWAY,
        :POSSIBLE_SAFETY_HOME,
        :POSSIBLE_SAFETY_AWAY,
        :POSSIBLE_TURNOVER_HOME,
        :POSSIBLE_TURNOVER_AWAY,
        :VIDEO_REVIEW,
        :REDZONE_HOME,
        :REDZONE_AWAY,
        :POSSIBLE_BOUNDARY,
        :POSSIBLE_WICKET,
        :POSSIBLE_CHALLENGE_HOME,
        :POSSIBLE_CHALLENGE_AWAY,
        :POSSIBLE_TURNOVER,
        :UNKNOWN_OPERATOR,
        :FREEBALL,
        :DEEP_BALL,
        :POSSIBLE_RUN,
        :MAINTENANCE,
        :BASE_HIT_DELETED,
        :MATCH_DELAYED,
        :MATCH_POSTPONED,
        :SCOUT_DISCONNECTION_TV_SIGNAL,
        :POSSIBLE_PENALTY_OFFSETTING,
        :POSSIBLE_PUNT_HOME,
        :POSSIBLE_PUNT_AWAY,
        :POSSIBLE_FOURTH_DOWN_ATTEMPT_HOME,
        :POSSIBLE_FOURTH_DOWN_ATTEMPT_AWAY,
        :POSSIBLE_ONSIDE_KICK_HOME,
        :POSSIBLE_ONSIDE_KICK_AWAY,
        :POSSIBLE_CHALLENGE,
        :POSSIBLE_CARD,
        :DELAYED_PENALTY,
        :SHOOTOUT_BEGINS,
        :EMPTY_NET,
        :POSSIBLE_TRY_HOME,
        :POSSIBLE_TRY_AWAY,
        :POSSIBLE_DROP_GOAL_HOME,
        :POSSIBLE_DROP_GOAL_AWAY,
        :POSSIBLE_CARD_HOME,
        :POSSIBLE_CARD_AWAY,
        :POSSIBLE_PENALTY_HOME_HOCKEY,
        :POSSIBLE_PENALTY_AWAY_HOCKEY,
        :DELAYED_PENALTY_HOME_HOCKEY,
        :DELAYED_PENALTY_AWAY_HOCKEY,
        :TWO_MAN_ADVANTAGE_HOME,
        :TWO_MAN_ADVANTAGE_AWAY,
        :POSSIBLE_FIELD_GOAL,
        :ROLLBACK_EVENT,
        :POSSIBLE_DROP_KICK_HOME,
        :POSSIBLE_DROP_KICK_AWAY,
        :POSSIBLE_DROP_KICK,
        :POSSIBLE_VIDEO_ASSISTANT_REFEREE,
        :FEED_INTERRUPTION,
        :POSSIBLE_SCORE,
        :POSSIBLE_SCORE_HOME,
        :POSSIBLE_SCORE_AWAY,
        :POSSIBLE_VIDEO_ASSISTANT_REFEREE_HOME,
        :POSSIBLE_VIDEO_ASSISTANT_REFEREE_AWAY
      ]
    )
  end

  def changeset(model \\ %__MODULE__{}, params) do
    params = sanitize(params)

    model
    |> cast(params, [:id, :description])
    |> apply
  end
end
