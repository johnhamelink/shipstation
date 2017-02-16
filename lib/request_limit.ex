defmodule Shipstation.RequestLimit do
  @moduledoc ~s"""
  This module is designed to record and handle the [backpressure
  obligations](https://www.shipstation.com/developer-api/#/introduction/shipstation-api-requirements/api-rate-limits)
  the API client has against the API.

  When a request is made, the response headers contain information about how
  many requests are allowed to be done within a given timeframe. This
  information is then stored in our Agent and used to determine if we should
  wait or not. Should the API Client go over the limit, the client will backoff,
  blocking the request until the elapsed time has been reached.
  """

  use Timex
  require Logger

  @default_duration 40
  @default_requests_allowed 40

  def start_link do
    Logger.info "Booting up RequestLimit Agent"
    Agent.start_link(fn ->
      {@default_requests_allowed, @default_requests_allowed, seconds_from_now(@default_duration)}
    end, name: __MODULE__)
  end

  @doc ~s"""
  This function allows us to anticipate whether the API will reject our request
  """
  @spec should_request?() :: boolean
  def should_request? do
    {_limit, remaining, reset} = Agent.get(__MODULE__, & &1)
    !(remaining == 0 && (Timex.now < reset))
  end

  @doc ~s"""
  Return the current state
  """
  @spec state() :: {integer, integer, %DateTime{}}
  def state do
    Agent.get(__MODULE__, & &1)
  end

  @doc ~s"""
  This function lets us set the rate information we're getting back from the API
  """
  @spec set_api_rate({atom, HTTPoison.Response.t}) :: any
  def set_api_rate({_, %HTTPoison.Response{headers: headers}}) do
    headers   = Enum.into(headers, %{})
    {limit, _}     = Integer.parse(Map.get(headers, "X-Rate-Limit-Limit", "40"))
    {remaining, _} = Integer.parse(Map.get(headers, "X-Rate-Limit-Remaining", "40"))
    {reset, _}     = Integer.parse(Map.get(headers, "X-Rate-Limit-Reset", "40"))

    state = {limit, remaining, seconds_from_now(reset)}
    Agent.update(__MODULE__, fn _ -> state end)
  end

  @doc ~s"""
  Wait a specified amount of time, so that the API has room to breathe
  """
  @spec backoff() :: any
  def backoff() do
    {_limit, _remaining, reset} = Agent.get(__MODULE__, & &1)

    period = calculate_backoff_period(reset)
    Logger.warn("Backing off Shipstation API for #{period}ms...")

    :timer.sleep(period)
  end

  @spec calculate_backoff_period(future_time :: %DateTime{}) :: non_neg_integer
  def calculate_backoff_period(future_time) do
    future_time
    |> Timex.diff(Timex.now, :milliseconds)
  end

  @doc false
  @spec seconds_from_now(integer) :: %DateTime{}
  def seconds_from_now(distance) do
    Timex.add(Timex.now, Timex.Duration.from_seconds(distance))
  end

end
