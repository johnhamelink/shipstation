defmodule Shipstation do
  use HTTPoison.Base

  #@base_uri %URI{scheme: "https", host: "ssapi.shipstation.com"}
  @base_uri %URI{scheme: "https", host: "private-anon-ab6eb750a3-shipstation.apiary-mock.com"}
  @default_headers [{"Accept", "application/json"}]

  def base_uri,
  do: @base_uri

  def call_api(verb, uri = %URI{}, body = %{}, headers \\ []) do
    case request(verb, uri, Poison.encode!(body), @default_headers ++ headers) do
      {:ok, resp} ->
        {:ok, %{Map.from_struct(resp) | body: Poison.decode!(resp.body)}}
      out -> out
    end
  end

end
