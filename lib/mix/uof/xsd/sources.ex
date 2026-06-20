defmodule Mix.UOF.XSD.Sources do
  @moduledoc false
  # Upstream XSD sources, pinned to a single SDK release tag so code
  # generation is reproducible. Schemas are downloaded on demand by
  # `mix uof.gen.schemas` and are never vendored into the repo (see
  # `.gitignore`). The public schema page is deliberately NOT used: it is
  # incomplete (no cashout/probability schema) and not tag-pinned.

  @sdk_repo "sportradar/UnifiedOddsSdkNetCore"
  @sdk_tag "v3.11.0"

  @priv "priv/xsd"

  @groups [:custombet, :unifiedfeed, :sports_api, :probability]

  def sdk_tag, do: @sdk_tag
  def groups, do: @groups

  @doc "Local directory where a group's XSDs are cached after download."
  def dir(group), do: Path.join(@priv, Atom.to_string(group))

  @doc """
  Download a group's XSDs from the pinned SDK tag into `dir(group)`,
  replacing any previous contents. Returns the directory.
  """
  def fetch!(group) when group in @groups do
    {:ok, _} = Application.ensure_all_started(:req)
    dir = dir(group)
    File.rm_rf!(dir)

    for {sdk_path, dest_rel} <- select(group) do
      dest = Path.join(dir, dest_rel)
      File.mkdir_p!(Path.dirname(dest))
      File.write!(dest, raw!(sdk_path))
    end

    dir
  end

  ## per-group source selection ---------------------------------------------

  # CustomBet endpoints (available selections, calculation, selections, ...).
  defp select(:custombet) do
    "ext/custombet/v1/endpoints/"
    |> under()
    |> Enum.map(&{&1, Path.basename(&1)})
  end

  # Sports API "unified" responses + their shared includes. Only the "unified"
  # profile is taken: it is self-contained (never references ../common/), and
  # includes/common defines same-named-but-different types (e.g. matchRound)
  # that would collide and win the merge, dropping fields. Paths are kept below
  # ext/bsa/v1/ to preserve the endpoints/ vs includes/ split (basenames
  # collide, e.g. result.xsd exists in both).
  defp select(:sports_api) do
    ["ext/bsa/v1/endpoints/unified/", "ext/bsa/v1/includes/unified/"]
    |> under()
    |> Enum.map(&{&1, String.replace_prefix(&1, "ext/bsa/v1/", "")})
  end

  # Recovery/Booking/Users response wrapper + betting/market descriptions.
  defp select(:unifiedfeed) do
    for f <- ~w(UnifiedFeedResponse.xsd UnifiedFeedDescriptions.xsd),
        do: {"ext/unifiedsdk/xsd/#{f}", f}
  end

  # Probability API (cashout). UnifiedFeed.xsd is pulled in only as a
  # type-definition dependency of the cashout schema, not as feed endpoints.
  defp select(:probability) do
    [
      {"ext/UnifiedFeedCashoutOdds.xsd", "UnifiedFeedCashoutOdds.xsd"},
      {"ext/unifiedsdk/xsd/UnifiedFeed.xsd", "UnifiedFeed.xsd"}
    ]
  end

  ## github (pinned tag) -----------------------------------------------------

  # All .xsd blob paths under the given prefix(es) in the pinned tree.
  defp under(prefixes) do
    prefixes = List.wrap(prefixes)

    tree()
    |> Enum.filter(fn p ->
      String.ends_with?(p, ".xsd") and Enum.any?(prefixes, &String.starts_with?(p, &1))
    end)
  end

  defp tree do
    url = "https://api.github.com/repos/#{@sdk_repo}/git/trees/#{@sdk_tag}?recursive=1"

    Req.get!(url, headers: ua()).body
    |> Map.fetch!("tree")
    |> Enum.filter(&(&1["type"] == "blob"))
    |> Enum.map(& &1["path"])
  end

  defp raw!(path) do
    Req.get!("https://raw.githubusercontent.com/#{@sdk_repo}/#{@sdk_tag}/#{path}", headers: ua()).body
  end

  defp ua, do: [{"user-agent", "uof_api-xsd-codegen"}]
end
