defmodule LemonEx.MixProject do
  use Mix.Project

  @version "0.1.7"
  @source_url "https://github.com/PJUllrich/lemon_ex"

  def project do
    [
      app: :lemon_ex,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.1"},
      {:jason, "~> 1.2"},
      {:plug, "~> 1.14"},
      {:plug_crypto, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:mock, "~> 0.3.8", only: :test}
    ]
  end

  defp package do
    [
      description: "An Elixir client for the API and Webhooks of LemonSqueezy.",
      files: ["lib", "LICENSE", "mix.exs", "README.md"],
      licenses: ["MIT"],
      maintainers: ["Peter Ullrich"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      extras: [
        "README.md",
        "LICENSE"
      ],
      main: "readme",
      source_url: @source_url,
      source_ref: "main",
      formatters: ["html"]
    ]
  end
end
