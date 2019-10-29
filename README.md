# HumanizeTime

## Description
HumanizeTime is an Elixir library for converting seconds and milliseconds into more human readable strings. It allows for custom formatting and flexibility.  

[Hex Docs](https://hexdocs.pm/humanize_time) (in progress).

## Installation

This package can be installed by adding `humanize_time` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:humanize_time, "~> 1.0.0"}
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

## Custom Formatter
`format_seconds` takes an optional keyword list of options. Currently, the only supported keyword is `:formatters`.  

**:formatters** 
Allows for custom formatting of the result string. Value must be a map containing `days`, `hours`, `minutes`, and/or `seconds` as keys, with an anonymous function as value.
Default values will replace missing or incorrect keys.

Example:
```elixir
opts = [
  formatters: %{
    days: fn day_val -> "#{day_value} D",
    hours: fn hour_val -> "#{hour_value} H",
    minutes: fn min_val -> "#{min_value} M",
    seconds: &("#{&1} S"),
  }
]

# 21 D 17 H
# 19 M 37 S
```


