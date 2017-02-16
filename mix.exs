defmodule Shipstation.Mixfile do
  use Mix.Project

  def project do
    [app: :shipstation,
     version: "0.3.4",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [
       vcr: :test, "vcr.delete": :test, "vcr.check": :test, "vcr.show": :test
     ],
     deps: deps(),
     package: package(),
     name: "Shipstation",
     description: "An elixir client library for shipstation",
     source_url: "https://github.com/johnhamelink/shipstation",
     homepage_url: "https://hexdocs.pm/shipstation",
     docs: [
       main: "Shipstation",
       logo: "misc/logo.png",
       extras: ["README.md"]
     ]
    ]
  end

  def application do
    [
      applications: applications() ++ applications(Mix.env),
      mod: {Shipstation, []}
    ]
  end

  defp applications, do: [:logger, :httpoison, :poison, :timex]
  defp applications(:test), do: [:exvcr, :credo]
  defp applications(:dev), do: [:credo, :dialyxir, :ex_doc, :eliver]
  defp applications(_), do: []

  defp package do
    [
      name: :shipstation,
      files: ["lib", "config", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["John Hamelink"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/johnhamelink/shipstation",
        "Docs"   => "https://hexdocs.pm/shipstation"
      }
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11.0"},
      {:poison, "~> 2.0"},
      {:exvcr, "~> 0.8", only: :test},
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:dialyxir, "~> 0.4", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.14", only: :dev},
      {:eliver, "~> 1.0.0", only: :dev},
      {:timex, "~> 3.1"}
    ]
  end
end
