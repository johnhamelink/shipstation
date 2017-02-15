defmodule Shipstation.RequestLimitTest do
  use ExUnit.Case, async: false
  doctest Shipstation.RequestLimit
  alias Shipstation.RequestLimit

  test "Backoff" do
    future_time = RequestLimit.seconds_from_now(60)
    assert RequestLimit.calculate_backoff_period(future_time) > 5900
  end
end
