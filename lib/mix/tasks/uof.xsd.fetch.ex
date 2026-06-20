defmodule Mix.Tasks.Uof.Xsd.Fetch do
  @moduledoc """
  Download the Betradar XSD files into the git-ignored `priv/xsd/` cache,
  pinned to the upstream SDK tag in `Mix.UOF.XSD.Sources`.

      mix uof.xsd.fetch              # all groups
      mix uof.xsd.fetch custombet    # a single group

  This is a convenience for inspecting/refreshing the schemas; `mix
  uof.gen.schemas` fetches what it needs on its own.
  """
  use Mix.Task

  @shortdoc "Download Betradar XSDs (pinned to the SDK tag)"

  @impl Mix.Task
  def run(args) do
    known = Mix.UOF.XSD.Sources.groups()

    groups =
      case args do
        [] ->
          known

        names ->
          by_string = Map.new(known, &{Atom.to_string(&1), &1})

          Enum.map(names, fn n ->
            by_string[n] || Mix.raise("unknown group #{inspect(n)}; known: #{inspect(known)}")
          end)
      end

    for group <- groups do
      dir = Mix.UOF.XSD.Sources.fetch!(group)
      count = dir |> Path.join("**/*.xsd") |> Path.wildcard() |> length()
      Mix.shell().info("#{group}: #{count} xsd -> #{dir}")
    end
  end
end
