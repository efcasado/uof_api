defmodule UOF.API.Descriptions do
  alias UOF.API.Utils.HTTP

  @doc """
  Describe all currently available markets.
  """
  def markets(lang \\ "en") do
    # TO-DO: Optional mappings
    endpoint = ["descriptions", lang, "markets.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.MarketDescriptions{})
  end

  @doc """
  Describe all sport-specific match status codes used during live matches in
  `odds_change` messages.
  """
  def match_statuses(lang \\ "en") do
    endpoint = ["descriptions", lang, "match_status.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.MatchStatusDescriptions{})
  end

  @doc """
  Describe all bet stop reasons.
  """
  @spec betstop_reasons :: {:ok, UOF.API.Mappings.BetStopReasonDescription.t()}
  def betstop_reasons do
    endpoint = ["descriptions", "betstop_reasons.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.BetStopReasonDescriptions{})
  end

  @doc """
  Describes all betting statuses used in `odds_change` messages.
  """
  def betting_statuses do
    endpoint = ["descriptions", "betting_status.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.BettingStatusDescriptions{})
  end

  @doc """
  Get a list of all variants and which markets they are used for.
  """
  def variants(lang \\ "en") do
    endpoint = ["descriptions", lang, "variants.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.VariantDescriptions{})
  end

  @doc """
  Describe all currently avbailable producers and their ids.
  """
  def producers do
    endpoint = ["descriptions", "producers.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.Producers{})
  end

  @doc """
  Describe all possible void reasons used in `bet_settlement` messages.
  """
  def void_reasons do
    endpoint = ["descriptions", "void_reasons.xml"]

    HTTP.get(endpoint, %UOF.API.Mappings.VoidReasonDescriptions{})
  end
end
