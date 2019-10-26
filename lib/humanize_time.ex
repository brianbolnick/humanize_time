defmodule HumanizeTime do
  @moduledoc """
  Module for converting seconds and milliseconds to human readable timestamps.
  """

  @type duration_map :: %{
          days: integer(),
          hours: integer(),
          minutes: integer(),
          seconds: integer()
        }

  @doc """
  Formatter for converting seconds to a human readable format

  ## Examples
      iex> HumanizeTime.format_seconds(23487)
      "6 hr 31 min"
  """
  @spec format_seconds(integer() | float(), keyword()) :: String.t()
  def format_seconds(seconds, opts \\ [])
  def format_seconds(nil, _), do: ""

  def format_seconds(seconds, opts) when is_float(seconds) do
    seconds
    |> Float.round()
    |> Kernel.trunc()
    |> format_seconds(opts)
  end

  def format_seconds(seconds, opts) do
    initial_acc = %{
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0
    }

    calculate_times(initial_acc, seconds)
    |> print_duration(opts[:formatters])
  end

  @spec calculate_times(duration_map(), integer()) :: duration_map()
  defp calculate_times(time_tracker, 0), do: time_tracker

  defp calculate_times(time_tracker, seconds) do
    day_seconds = 86_400
    hour_seconds = 3_600
    minute_seconds = 60

    cond do
      seconds / day_seconds >= 1 ->
        days = time_tracker.days + div(seconds, day_seconds)
        remaining_seconds = seconds - days * day_seconds
        calculate_times(%{time_tracker | days: days}, remaining_seconds)

      seconds / hour_seconds >= 1 ->
        hours = time_tracker.hours + div(seconds, hour_seconds)
        remaining_seconds = seconds - hours * hour_seconds
        calculate_times(%{time_tracker | hours: hours}, remaining_seconds)

      seconds / minute_seconds >= 1 ->
        minutes = time_tracker.minutes + div(seconds, minute_seconds)
        remaining_seconds = seconds - minutes * minute_seconds
        calculate_times(%{time_tracker | minutes: minutes}, remaining_seconds)

      true ->
        %{time_tracker | seconds: seconds}
    end
  end

  @spec print_duration(duration_map(), duration_map() | nil) :: String.t()
  defp print_duration(duration, formatters) do
    %{days: days, hours: hours, minutes: minutes, seconds: seconds} = duration

    default_formatter = default_formatters()

    formats =
      case formatters do
        nil -> default_formatter
        user_formats -> user_formats
      end

    days_f = formats[:days] || default_formatter[:days]
    hours_f = formats[:hours] || default_formatter[:hours]
    minutes_f = formats[:minutes] || default_formatter[:minutes]
    seconds_f = formats[:seconds] || default_formatter[:seconds]

    cond do
      days > 0 ->
        day_string = days_f.(days)

        rounded_hours =
          if minutes >= 30 do
            hours + 1
          else
            hours
          end

        hour_string = hours_f.(rounded_hours)
        String.trim("#{day_string} #{hour_string}")

      hours > 0 ->
        hour_string = hours_f.(hours)

        rounded_mins =
          if seconds >= 30 do
            minutes + 1
          else
            minutes
          end

        minute_string = minutes_f.(rounded_mins)
        String.trim("#{hour_string} #{minute_string}")

      minutes > 0 ->
        minute_string = minutes_f.(minutes)
        seconds_string = seconds_f.(seconds)
        String.trim("#{minute_string} #{seconds_string}")

      true ->
        String.trim(seconds_f.(seconds))
    end
  end

  @spec print_days(integer()) :: String.t()
  defp print_days(0), do: ""
  defp print_days(1), do: "1 day"
  defp print_days(duration), do: "#{duration} days"

  @spec print_hours(integer()) :: String.t()
  defp print_hours(0), do: ""
  defp print_hours(duration), do: "#{duration} hr"

  @spec print_minutes(integer()) :: String.t()
  defp print_minutes(0), do: ""
  defp print_minutes(duration), do: "#{duration} min"

  @spec print_seconds(integer()) :: String.t()
  defp print_seconds(0), do: ""
  defp print_seconds(duration), do: "#{duration} sec"

  defp default_formatters do
    %{
      days: fn day -> print_days(day) end,
      hours: fn hour -> print_hours(hour) end,
      minutes: fn minute -> print_minutes(minute) end,
      seconds: fn second -> print_seconds(second) end
    }
  end
end
