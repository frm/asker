defmodule Asker.MixProject do
  use Mix.Project

  def project do
    [
      app: :asker,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Asker.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 2.2"},
      {:postgrex, ">= 0.0.0"},
      {:slack, "~> 0.14.0"},
      {:tesla, "~> 1.2.0"},
      {:jason, "~> 1.1.0"},
      {:quantum, "~> 2.3"},
      {:plug, "~> 1.7.0"},
      {:cowboy, "~> 1.1.0"},
      {:cowlib, "~> 1.0.0"},
      {:ranch, "~> 1.3.2"},
      {:plug_cowboy, "~> 1.0"},
      {:timex, "~> 3.0"},
      {:credo, "~> 0.10.0", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.2", only: :test},
      {:faker, "~> 0.11", only: :test},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
