defmodule UofApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :uof_api,
      version: "1.1.0",
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
      {:saxaboom, "0.2.1"},
      {:saxy, "~> 1.5"},
      {:req, "~> 0.4.14"},
      {:xml_builder, "~> 2.3"},
      # dev
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:mock, "~> 0.3.8", only: :test}
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
