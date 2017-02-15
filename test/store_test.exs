defmodule Shipstation.StoreTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Store

  setup_all do
    HTTPoison.start
  end

  test "Get Store" do
    use_cassette "store_get" do
      {:ok, %{body: body}} = resp = Shipstation.Store.get(12345)
      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["storeId"]) == 12345
    end
  end

  test "Deactivate Store" do
    use_cassette "store_deactivate" do
      {:ok, %{body: body}} = resp = Shipstation.Store.deactivate(12345)
      assert {:ok, %{status_code: 200}} = resp
      # This is an API bug!
      assert body == %{"message" => "The requested store has been reactivated.", "success" => "true"}
    end
  end

  test "Reactivate Store" do
    use_cassette "store_reactivate" do
      {:ok, %{body: body}} = resp = Shipstation.Store.reactivate(12345)
      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"message" => "The requested store has been reactivated.", "success" => "true"}
    end
  end

  test "List Stores" do
    use_cassette "list_stores" do
      params = %Shipstation.Structs.Store{
        showInactive: false,
        marketplaceId: nil
      }
      {:ok, %{body: body}} = resp = Shipstation.Store.list(params)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(get_in(body, [all, "storeName"])) == ["Ashley's Test WooCommerce", "ShipStation Manual Store"]
    end
  end

  test "List Marketplaces" do
    use_cassette "list_marketplaces" do
      {:ok, %{body: body}} = resp = Shipstation.Store.list_marketplaces
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(get_in(body, [all, "name"])) == ["3DCart", "Amazon", "Amazon CA"]
    end
  end

  test "Get Store Refresh Status" do
    use_cassette "store_refresh_status" do
      {:ok, %{body: body}} = resp = Shipstation.Store.refresh_status(12_345)
      assert {:ok, %{status_code: 200}} = resp

      assert get_in(body, ["refreshStatus"]) == "Updating orders"
    end
  end

  test "Refresh a store" do
    use_cassette "store_refresh" do
      {:ok, %{body: body}} = resp = Shipstation.Store.refresh(12_345, "12-08-2014")
      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["storeName"]) == "WooCommerce Store"
    end
  end

end
