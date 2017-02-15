defmodule Shipstation do
  @moduledoc ~s"""
    Shipstation is a piece of software which makes it easy to import, manage and
    ship your orders. They aim to streamline shipping for online sellers, no
    matter where they sell their products online.

    This hex package is designed to allow you to integrate your ecommerce
    product with Shipstation's [publicly accessible
    API](http://www.shipstation.com/developer-api/).
  """

  use HTTPoison.Base
  require Logger

  @default_headers [{"Accept", "application/json"}]
  @type response_type :: {atom, map}

  def base_uri,
  do: URI.parse(Application.get_env(:shipstation, :base_uri))

  @doc ~s"""
  This function decides if there is enough data to build a Basic Authentication
  header to add into the request. This is useful because it will attempt to make
  the request without the header if there isn't enough data. You might want to do
  this if you are wanting to create a new account through the API.
  """
  def auth do
    case Application.get_env(:shipstation, :auth) do
      %{api_key: nil} -> []
      %{api_secret: nil} -> []
      %{api_key: key, api_secret: secret} ->
        [{:basic_auth, {key, secret}}]
      _ -> []
    end
  end

  @doc ~s"""
  This is the function that calls the API on behalf of the rest of the codebase.
  It will compile the component pieces of the request and add in authentication
  information when necessary.
  """
  @spec call_api(verb :: atom, uri :: URI.t, body :: map | list(map), custom_headers :: list(map)) :: response_type
  def call_api(verb, uri = %URI{}, body, custom_headers \\ []) do

    # Build up final HTTP request to be sent to the API
    payload = Poison.encode!(body)
    headers = @default_headers ++ custom_headers
    options = [] ++ auth()

    case request(verb, uri, payload, headers, options) do
      {:ok, resp = %{body: ""}} ->
        %{status_code: resp.status_code}
      {:ok, resp = %{body: _}} ->
        return_json(resp)
      out -> out
    end
  end

  defp return_json(resp) do
    case Poison.decode(resp.body) do
      {:ok, body} ->
        {:ok, %{Map.from_struct(resp) | body: body}}
      {:error, _err} ->
        Logger.error("Could not parse JSON: #{resp.body}")
        {:error, "Could not parse JSON: #{resp.body}"}
    end
  end

end
