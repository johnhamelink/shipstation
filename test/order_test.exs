defmodule Shipstation.OrderTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Order

  setup_all do
    HTTPoison.start
  end

  test "Get an order" do
    use_cassette "get_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.get(123456789)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert body["orderId"] == 94113592
      assert get_in(body, ["billTo", "name"]) == "The President"
      assert get_in(body, ["shipTo", "phone"]) == "555-555-5555"
      assert get_in(body, ["items", all, "lineItemKey"]) == ["vd08-MSLbtx", nil]
    end
  end

  test "Delete an order" do
    use_cassette "delete_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.delete(123456789)
      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"success" => true, "message" => "The requested order has been deleted."}
    end
  end

  test "Add a tag to an order" do
    use_cassette "add_tag_to_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.add_tag(123456, 1234)
      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"success" => true, "message" => "Tag added successfully."}
    end
  end

  test "Assign a user to an order" do
    use_cassette "assign_user_to_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.assign_user(
        [123456789, 12345679], "123456AB-ab12-3c4d-5e67-89f1abc1defa")

      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"success" => true, "message" => "User assigned successfully."}
    end
  end

  test "Create a label for an order" do
    use_cassette "create_label_for_order" do
      params = %Shipstation.Structs.Order{
        orderId: 93_348_442,
        carrierCode: "fedex",
        serviceCode: "fedex_2day",
        packageCode: "package",
        confirmation: nil,
        shipDate: "2014-04-03",
        weight: %Shipstation.Structs.Weight{value: 2, units: "pounds"},
        dimensions: nil,
        insuranceOptions: nil,
        internationalOptions: nil,
        advancedOptions: nil,
        testLabel: false
      }

      {:ok, %{body: body}} = resp = Shipstation.Order.create_label(params)

      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["shipmentId"]) == 72_513_480
    end
  end

end
