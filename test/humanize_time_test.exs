defmodule HumanizeTimeTest do
  use ExUnit.Case
  doctest HumanizeTime

  describe "HumanizeTime.format_seconds/1" do
    test "properly formats a time" do
      min_sec = HumanizeTime.format_seconds(125)
      hr_min = HumanizeTime.format_seconds(3_660)
      day_hr = HumanizeTime.format_seconds(86_460)
      days_hr = HumanizeTime.format_seconds(90_000)
      assert min_sec == "2 min 5 sec"
      assert hr_min == "1 hr 1 min"
      assert day_hr == "1 day"
      assert days_hr == "1 day 1 hr"
    end

    test "formats with seconds only" do
      res = HumanizeTime.format_seconds(59)
      assert res == "59 sec"
    end

    test "formats with minutes only" do
      res = HumanizeTime.format_seconds(120)
      assert res == "2 min"
    end

    test "formats with hours only" do
      res = HumanizeTime.format_seconds(3_600)
      assert res == "1 hr"
    end

    test "formats with days only" do
      res = HumanizeTime.format_seconds(172_800)
      assert res == "2 days"
    end

    test "correctly pluralizes days" do
      res = HumanizeTime.format_seconds(86_400)
      res_plural = HumanizeTime.format_seconds(172_800)
      assert res == "1 day"
      assert res_plural == "2 days"
    end

    test "shows a maximum of 2 time periods" do
      # 1 hr 1 min 5 sec
      res = HumanizeTime.format_seconds(3_665)
      assert res == "1 hr 1 min"
    end

    test "correctly rounds time periods when truncated" do
      # 1 hr 1 min 29 sec"
      secs_down = HumanizeTime.format_seconds(3_689)
      assert secs_down == "1 hr 1 min"

      # 1 hr 1 min 30 sec"
      secs_up = HumanizeTime.format_seconds(3_690)
      assert secs_up == "1 hr 2 min"

      # 1 day 1 hr 29 min"
      mins_down = HumanizeTime.format_seconds(91_740)
      assert mins_down == "1 day 1 hr"

      # 1 day 1 hr 30 min"
      mins_up = HumanizeTime.format_seconds(91_800)
      assert mins_up == "1 day 2 hr"
    end

    test "handles nil values" do
      res = HumanizeTime.format_seconds(nil)
      assert res == ""
    end

    test "handles custom formatters" do
      opts = [
        formatters: %{
          days: fn day -> "#{day} dayz" end,
          hours: fn hour -> "#{hour} hourz" end,
          minutes: &"#{&1} minz",
          seconds: fn sec -> "#{sec} secz" end
        }
      ]

      res = HumanizeTime.format_seconds(76543, opts)
      assert res == "21 hourz 16 minz"
    end

    test "uses default formatters when incorrect or missing formatters are provided" do
      opts = [
        formatters: %{
          ds: fn day -> "#{day} dayz" end,
          hours: fn hour -> "#{hour} hourz" end,
          seconds: fn sec -> "#{sec} secz" end
        }
      ]

      res = HumanizeTime.format_seconds(76543, opts)
      assert res == "21 hourz 16 min"
    end
  end
    test "handles negative input" do
      res = HumanizeTime.format_seconds(-4321)
      assert res == "-1 hr 12 min"
    end


end
