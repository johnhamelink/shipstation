defmodule Shipstation.Webhook do
  @moduledoc ~s"""
  Manage webhooks associated with your account
  """

  @doc ~s"""
  Retrieves a list of registered webhooks for the account
  """
  @spec list() :: Shipstation.Client.response_type
  def list() do
    uri = %{Shipstation.Client.base_uri | path: "/webhooks"}
    Shipstation.Client.call_api(:get, uri, %{})
  end

  @doc ~s"""
  Subscribes to a specific type of webook. If a `store_id` is passed in, the
  webhooks will only be triggered for that specific `store_id`. The event type
  that is passed in will determine what type of webhooks will be sent.

  NOTE: Webhooks will be sent to the URL specified in the `target_url`. The HTTP
  request will be sent via POST and will contain a [webhook JSON
  object](https://www.shipstation.com/developer-api/#/reference/model-webhook)
  in the body.
  """
  @spec subscribe(webhook :: Shipstation.Structs.Webhook.t) :: Shipstation.Client.response_type
  def subscribe(webhook) do
    uri = %{Shipstation.Client.base_uri | path: "/webhooks/subscribe"}
    Shipstation.Client.call_api(:post, uri, webhook)
  end

  @doc ~s"""
  Unsubscribes from a certain webhook.
  """
  @spec unsubscribe(webhook_id :: integer) :: Shipstation.Client.response_type
  def unsubscribe(webhook_id) do
    uri = %{Shipstation.Client.base_uri | path: "/webhooks/#{webhook_id}"}
    Shipstation.Client.call_api(:delete, uri, %{})
  end

end
