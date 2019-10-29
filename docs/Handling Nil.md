# Handling Nil Values

**Set a fallback for `nil` input**

## Nil Fallbackl

Add custom fallback to `HumanizeTime.format_seconds/2` for nil values.

```elixir
opts = [
	nil_fallback: "No current data.
]

> HumanizeTime.format_seconds(nil, opts)

# No current data.
```


