defmodule Cryptex.Mixfile do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :cryptex,
      version: @version,
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      package: package(),
      docs: [extras: ["README.md"]],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 0.13"},
      {:poison, "~> 3.1"},
      {:atomic_map, "~> 0.8"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      description: "A thin wrapper around Cryptowat.ch public API",
      licenses: ["MIT License"],
      maintainers: ["Mads Hargreave"],
      links: %{
        github: "https://github.com/madshargreave/cryptex",
        docs: "http://hexdocs.pm/cryptex/#{@version}/"
      }
    ]
  end

end
