defmodule UofApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :uof_api,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:sweet_xml, "~> 0.7.4"},
      {:req, "~> 0.4.14"},
      # dev
      {:ex_doc, "~> 0.31", only: :dev, runtime: false}
    ]
  end
end
