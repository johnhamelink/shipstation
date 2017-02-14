defmodule Shipstation do
  @moduledoc ~s"""
    Shipstation is a piece of software which makes it easy to import, manage and
    ship your orders. They aim to streamline shipping for online sellers, no
    matter where they sell their products online.

    This hex package is designed to allow you to integrate your ecommerce product
    with Shipstation's publicly accessible API
    (http://www.shipstation.com/developer-api/).
  """

  use HTTPoison.Base
  require Logger

  #@base_uri %URI{scheme: "https", host: "ssapi.shipstation.com"}
  @base_uri %URI{scheme: "https", host: "private-anon-ab6eb750a3-shipstation.apiary-mock.com"}
  @default_headers [{"Accept", "application/json"}]

  def base_uri,
  do: @base_uri

  @type response_type :: {atom, map}

  @spec call_api(verb :: atom, uri :: URI.t, body :: map, headers :: list(map)) :: response_type
  def call_api(verb, uri = %URI{}, body = %{}, headers \\ []) do
    case request(verb, uri, Poison.encode!(body), @default_headers ++ headers) do
      {:ok, resp} ->
        return_json(resp)
      out -> out
    end
  end

  defp return_json(resp) do
    case Poison.decode(resp.body) do
      {:ok, body} ->
        {:ok, %{Map.from_struct(resp) | body: body}}
      {:error, err} ->
        Logger.error("Could not parse JSON: #{resp.body}")
        {:error, "Could not parse JSON: #{resp.body}"}
    end
  end

end
