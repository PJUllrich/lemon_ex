defmodule LemonEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :lemon_ex,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
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
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:plug, "~> 1.14"},
      {:plug_crypto, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "An Elixir client for the API and Webhooks of LemonSqueezy.",
      files: ["lib", "LICENSE*", "mix.exs", "README*"],
      licenses: ["MIT"],
      maintainers: ["Peter Ullrich"],
      links: %{"GitHub" => "https://github.com/PJUllrich/lemon_ex"}
    ]
  end
end
