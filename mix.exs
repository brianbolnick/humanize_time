defmodule HumanizeTime.MixProject do
  use Mix.Project

  @version "0.0.1"

  def project do
    [
      app: :humanize_time,
      version: @version,
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs()
    ]
  end

  defp description do
    """
    HumanizeTime is an Elixir library for converting seconds and milliseconds into more human readable strings. 
    It allows for custom formatting and flexibility.
    """
  end

  defp package do
    [
      files: ["lib", "priv", "mix.exs", "README.md", "LICENSE.md"],
      maintainers: ["Brian Bolnick"],
      licenses: ["MIT"],
      links: %{
        Changelog: "https://github.com/brianbolnick/humanize_time/blob/master/CHANGELOG.md",
        GitHub: "https://github.com/brianbolnick/humanize_time"
      }
    ]
  end

  defp docs do
    [
      main: "getting-started",
      formatter_opts: [gfm: true],
      source_ref: @version,
      source_url: "https://github.com/brianbolnick/humanize_time",
      extras: [
        "CHANGELOG.md",
        "docs/Getting Started.md"
        # "docs/Basic Usage.md",
        # "docs/Erlang Interop.md",
        # "docs/Formatting.md",
        # "docs/Parsing.md",
        # "docs/FAQ.md",
        # "docs/Using with Ecto.md",
        # "docs/Custom Parsers.md",
        # "docs/Custom Formatters.md"
      ]
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
      {:ex_doc, "~> 0.18", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end