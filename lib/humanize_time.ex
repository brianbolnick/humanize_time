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
  """
  @spec format_seconds(integer() | float()) :: String.t()
  def format_seconds(nil), do: ""

  def format_seconds(seconds) when is_float(seconds) do
    seconds
    |> Float.round()
    |> Kernel.trunc()
    |> format_seconds()
  end

  def format_seconds(seconds) do
    initial_acc = %{
      days: 0,
      hours: 0,
      minutes: 0,
      seconds: 0
    }

    calculate_times(initial_acc, seconds)
    |> print_duration()
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

  @spec print_duration(duration_map()) :: String.t()
  defp print_duration(duration) do
    %{days: days, hours: hours, minutes: minutes, seconds: seconds} = duration

    cond do
      days > 0 ->
        day_string = print_days(days)
        hour_string = print_hours(hours, minutes)
        String.trim("#{day_string} #{hour_string}")

      hours > 0 ->
        hour_string = print_hours(hours, 0)
        minute_string = print_minutes(minutes, seconds)
        String.trim("#{hour_string} #{minute_string}")

      minutes > 0 ->
        minute_string = print_minutes(minutes, 0)
        seconds_string = print_seconds(seconds)
        String.trim("#{minute_string} #{seconds_string}")

      true ->
        String.trim(print_seconds(seconds))
    end
  end

  @spec print_days(integer()) :: String.t()
  defp print_days(0), do: ""
  defp print_days(1), do: "1 day"
  defp print_days(duration), do: "#{duration} days"

  @spec print_hours(integer(), integer()) :: String.t()
  defp print_hours(0, _), do: ""
  defp print_hours(duration, minutes) when minutes >= 30, do: "#{duration + 1} hr"
  defp print_hours(duration, _), do: "#{duration} hr"

  @spec print_minutes(integer(), integer()) :: String.t()
  defp print_minutes(0, _), do: ""
  defp print_minutes(duration, seconds) when seconds >= 30, do: "#{duration + 1} min"
  defp print_minutes(duration, _), do: "#{duration} min"

  @spec print_seconds(integer()) :: String.t()
  defp print_seconds(0), do: ""
  defp print_seconds(duration), do: "#{duration} sec"
end
