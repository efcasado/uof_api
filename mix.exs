defmodule UofApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :uof_api,
      version: "2.0.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      docs: docs(),
      deps: deps(),
      name: "UOF_API",
      source_url: "https://github.com/efcasado/uof_api"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:saxy, "~> 1.5"},
      {:ecto, "~> 3.12"},
      {:req, "~> 0.6.2"},
      {:xml_builder, "~> 2.3"},
      # dev
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:mimic, "~> 2.3", only: :test}
    ]
  end

  defp description() do
    "An Elixir client for Betradar's Unified Odds Feed (UOF) API"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/efcasado/uof_api"}
    ]
  end

  defp docs() do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end
end
