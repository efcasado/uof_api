defmodule UofApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :uof_api,
      version: "1.0.0",
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
      {:saxaboom, "0.2.1"},
      {:saxy, "~> 1.5"},
      {:req, "~> 0.4.14"},
      {:xml_builder, "~> 2.3"},
      # dev
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:mock, "~> 0.3.8", only: :test}
    ]
  end
end
