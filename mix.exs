defmodule Shipstation.Mixfile do
  use Mix.Project

  def project do
    [app: :shipstation,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     preferred_cli_env: [
       vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
     ],

     name: "Shipstation",
     source_url: "https://github.com/johnhamelink/shipstation",
     homepage_url: "https://hexdocs.pm/shipstation",
     docs: [
       main: "Shipstation",
       logo: "misc/logo.png",
       extras: ["README.md"]
     ]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: applications() ++ applications(Mix.env)]
  end

  def applications, do: [:logger, :httpoison, :poison]
  def applications(:test), do: [:exvcr, :credo]
  def applications(:dev), do: [:credo, :dialyxir, :ex_doc, :eliver]
  def applications(_), do: []

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11.0"},
      {:poison, "~> 3.1"},
      {:exvcr, "~> 0.8", only: :test},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev},
      {:eliver, "~> 1.0.0", only: :dev}
    ]
  end
end
