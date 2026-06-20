defmodule Mix.Tasks.Uof.Gen.Schemas do
  @moduledoc """
  Generate Ecto embedded schemas from Betradar's XSD files.

      mix uof.gen.schemas

  XSDs are downloaded on demand from the upstream SDK, pinned to the tag in
  `Mix.UOF.XSD.Sources`, into the (git-ignored) `priv/xsd/` cache — they are
  never vendored. Currently wired for the CustomBet schema group: one module
  per `complexType` is generated into `lib/uof/api/schemas/custom_bet/`.
  """
  use Mix.Task

  @shortdoc "Generate Ecto embedded schemas from XSDs"

  # {fetch_group, namespace, output dir, roots}
  #
  # `fetch_group` names the XSD source (see `Mix.UOF.XSD.Sources`); several
  # entries may share one source (e.g. descriptions + response both come from
  # :unifiedfeed). `roots` is the allow-list of root *element* names to generate
  # from: only complexTypes reachable from these are emitted, so unused
  # endpoints in the schema set are pruned. Use `:all` to generate everything.
  @groups [
    {:custombet, "UOF.API.Schemas.CustomBet", "lib/uof/api/schemas/custom_bet",
     ~w(available_selections calculation_response filtered_calculation_response response)},
    {:probability, "UOF.API.Schemas.Probability", "lib/uof/api/schemas/probability", ~w(cashout)},
    {:unifiedfeed, "UOF.API.Schemas.Descriptions", "lib/uof/api/schemas/descriptions",
     ~w(market_descriptions match_status_descriptions betstop_reasons_descriptions
        betting_status_descriptions variant_descriptions producers void_reasons_descriptions)},
    {:unifiedfeed, "UOF.API.Schemas.Response", "lib/uof/api/schemas/response",
     ~w(response bookmaker_details)},
    {:sports_api, "UOF.API.Schemas.Sports", "lib/uof/api/schemas/sports",
     ~w(fixtures_fixture schedule fixture_changes result_changes match_summary match_timeline
        sports sport_categories tournaments tournament_info player_profile competitor_profile
        venue_summary)}
  ]

  @impl Mix.Task
  def run(_args) do
    # Fetch each distinct source once, then generate every entry from the cache.
    @groups
    |> Enum.map(&elem(&1, 0))
    |> Enum.uniq()
    |> Enum.each(fn group ->
      Mix.shell().info("fetching #{group} XSDs from SDK #{Mix.UOF.XSD.Sources.sdk_tag()} ...")
      Mix.UOF.XSD.Sources.fetch!(group)
    end)

    for {group, namespace, out_dir, roots} <- @groups do
      generate_group(group, namespace, out_dir, roots)
    end
  end

  defp generate_group(group, namespace, out_dir, roots) do
    paths = Path.wildcard(Path.join(Mix.UOF.XSD.Sources.dir(group), "**/*.xsd"))
    {types, parsed_roots} = Mix.UOF.XSD.parse_files(paths)
    types = scope(types, parsed_roots, roots)

    # Regenerate from scratch so pruned/renamed types don't leave stale modules.
    File.rm_rf!(out_dir)
    File.mkdir_p!(out_dir)

    for {short_name, source} <- Mix.UOF.XSD.Generator.generate(types, namespace) do
      file = Path.join(out_dir, Macro.underscore(short_name) <> ".ex")
      formatted = IO.iodata_to_binary(Code.format_string!(source))
      File.write!(file, formatted <> "\n")
      Mix.shell().info("generated #{file}")
    end
  end

  defp scope(types, _parsed_roots, :all), do: types

  defp scope(types, parsed_roots, roots) do
    root_type_names = Mix.UOF.XSD.root_types(parsed_roots, roots)
    Mix.UOF.XSD.reachable_types(types, root_type_names)
  end
end
