defmodule Shipstation.WebhookTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Webhook

  setup_all do
    HTTPoison.start
  end

  test "List Webhooks" do
    use_cassette "webhook_list" do
      {:ok, %{body: body}} = resp = Shipstation.Webhook.list
      all = fn :get, data, next -> Enum.map(data, next) end

      assert {:ok, %{status_code: 200}} = resp
      assert Enum.sort(get_in(body, ["webhooks", all, "WebHookID"])) == [123, 456]
    end
  end

  test "Subscribe to Webhook" do
    use_cassette "webhook_subscribe" do
      params = %Shipstation.Structs.Webhook{
        target_url: "http://someexamplewebhookurl.com/neworder",
        event: "ORDER_NOTIFY",
        store_id: nil,
        friendly_name: "My Webhook"
      }
      {:ok, %{body: body}} = resp = Shipstation.Webhook.subscribe(params)

      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"id" => 123_456}
    end
  end

  test "Unsubscribe to Webhook" do
    use_cassette "webhook_unsubscribe" do
      assert %{status_code: 200} = Shipstation.Webhook.unsubscribe(12345)
    end
  end

end
