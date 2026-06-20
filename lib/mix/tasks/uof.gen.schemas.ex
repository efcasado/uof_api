defmodule Mix.Tasks.Uof.Gen.Schemas do
  @moduledoc """
  Generate Ecto embedded schemas from the XSDs cached under `priv/xsd/`.

      mix uof.xsd.fetch     # download the XSDs first (pinned SDK tag)
      mix uof.gen.schemas   # then generate

  Reads the (git-ignored) `priv/xsd/` cache populated by `mix uof.xsd.fetch`
  and raises if a group's XSDs are missing. One module per `complexType` is
  generated per group into `lib/uof/api/schemas/<group>/`.
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
    for {group, namespace, out_dir, roots} <- @groups do
      generate_group(group, namespace, out_dir, roots)
    end
  end

  defp generate_group(group, namespace, out_dir, roots) do
    dir = Mix.UOF.XSD.Sources.dir(group)
    paths = Path.wildcard(Path.join(dir, "**/*.xsd"))

    if paths == [] do
      Mix.raise("no XSDs found in #{dir} for #{group}; run `mix uof.xsd.fetch` first")
    end

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
