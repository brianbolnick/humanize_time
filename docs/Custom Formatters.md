# Custom Formatters

**Customize the formatted output with custom options.**

## Formatters

Add custom formatters to `HumanizeTime.format_seconds/2`.

```elixir
opts = [
  formatters: %{
    days: fn day_val -> "#{day_value} D",
    hours: fn hour_val -> "#{hour_value} H",
    minutes: fn min_val -> "#{min_value} M",
    seconds: &("#{&1} S"),
  }
]

> HumanizeTime.format_seconds(23487, opts)
# "6 H 31 M"
```

If keys are incorrect or missing, `format_seconds/2` will use the default formatters.


