# HumanizeTime

## Description
HumanizeTime is an Elixir library for converting seconds and milliseconds into more human readable strings. It allows for custom formatting and flexibility.  

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `humanize_time` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:humanize_time, "~> 0.0.1"}
  ]
end
```

## Example Usage
Currently, all formats are fixed and will show a maximum of 2 time periods.

```elixir
> HumanizeTime.format_seconds(3600)
# "1 hr"

> HumanizeTime.format_seconds(23487)
# "6 hr 31 min"
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/humanize_time](https://hexdocs.pm/humanize_time).

