defmodule Shipstation.OrderTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Order

  setup_all do
    HTTPoison.start
  end

  setup do
    order = %Shipstation.Structs.Order{
        orderNumber: "TEST-ORDER-API-DOCS",
        orderKey: nil,
        orderDate: "2015-06-29T08:46:27.0000000",
        paymentDate: "2015-06-29T08:46:27.0000000",
        shipByDate: "2015-07-05T00:00:00.0000000",
        orderStatus: "awaiting_shipment",
        customerId: 37_701_499,
        customerUsername: "headhoncho@whitehouse.gov",
        customerEmail: "headhoncho@whitehouse.gov",
        billTo: %Shipstation.Structs.Address{
          name: "The President",
          company: nil,
          street1: nil,
          street2: nil,
          street3: nil,
          city: nil,
          state: nil,
          postalCode: nil,
          country: nil,
          phone: nil,
          residential: nil
        },
        shipTo: %Shipstation.Structs.Address{
          name: "The President",
          company: "US Govt",
          street1: "1600 Pennsylvania Ave",
          street2: "Oval Office",
          street3: nil,
          city: "Washington",
          state: "DC",
          postalCode: "20500",
          country: "US",
          phone: "555-555-5555",
          residential: true
        },
        items: [
          %Shipstation.Structs.OrderItem{
            lineItemKey: "vd08-MSLbtx",
            sku: "ABC123",
            name: "Test item #1",
            imageUrl: nil,
            weight: %Shipstation.Structs.Weight{
              value: 24,
              units: "ounces"
            },
            quantity: 2,
            unitPrice: 99.99,
            taxAmount: 2.5,
            shippingAmount: 5,
            warehouseLocation: "Aisle 1, Bin 7",
            options: [
              %Shipstation.Structs.ItemOption{
                name: "Size",
                value: "Large"
              }
            ],
            productId: 123_456,
            fulfillmentSku: nil,
            adjustment: false,
            upc: "32-65-98"
          }
        ],
        amountPaid: 218.73,
        taxAmount: 5,
        shippingAmount: 10,
        customerNotes: "Thanks for ordering",
        internalNotes: "Customer called and would like to upgrade shipping",
        gift: true,
        giftMessage: "Thank you!",
        paymentMethod: "Credit Card",
        requestedShippingService: "Priority Mail",
        carrierCode: "fedex",
        serviceCode: "fedex_2day",
        packageCode: "package",
        confirmation: "delivery",
        shipDate: "2015-07-02",
        weight: %Shipstation.Structs.Weight{value: 25, units: "ounces"},
        dimensions: %Shipstation.Structs.Dimension{
          units: "inches",
          length: 7,
          width: 5,
          height: 6
        },
        insuranceOptions: %Shipstation.Structs.InsuranceOption{
          provider: "carrier",
          insureShipment: true,
          insuredValue: 200
        },
        internationalOptions: nil,
        advancedOptions: nil,
        tagIds: nil,
        userId: nil,
        externallyFulfilled: false,
        externallyFulfilledBy: nil
      }
    {:ok, [order: order]}
  end

  test "Get an order" do
    use_cassette "get_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.get(123_456_789)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert body["orderId"] == 94_113_592
      assert get_in(body, ["billTo", "name"]) == "The President"
      assert get_in(body, ["shipTo", "phone"]) == "555-555-5555"
      assert get_in(body, ["items", all, "lineItemKey"]) == ["vd08-MSLbtx", nil]
    end
  end

  test "Delete an order" do
    use_cassette "delete_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.delete(123_456_789)
      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"success" => true, "message" => "The requested order has been deleted."}
    end
  end

  test "Add a tag to an order" do
    use_cassette "add_tag_to_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.add_tag(123_456, 1234)
      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"success" => true, "message" => "Tag added successfully."}
    end
  end

  test "Assign a user to an order" do
    use_cassette "assign_user_to_order" do
      {:ok, %{body: body}} = resp = Shipstation.Order.assign_user(
        [123_456_789, 12_345_679], "123456AB-ab12-3c4d-5e67-89f1abc1defa")

      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"success" => true, "message" => "User assigned successfully."}
    end
  end

  test "Create a label for an order" do
    use_cassette "create_label_for_order" do
      params = %Shipstation.Structs.Label{
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

  test "Update an order", context do
    use_cassette "update_order" do
      params = %{ context[:order] | orderKey: "0f6bec18-3e89-4881-83aa-f392d84f4c74" }
      {:ok, %{body: body}} = resp = Shipstation.Order.upsert_order(params)

      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["orderKey"]) == "0f6bec18-3e89-4881-83aa-f392d84f4c74"
    end
  end

  test "Create Order", context do
    use_cassette "create_order" do
      params = %{ context[:order] | orderKey: nil }
      {:ok, %{body: body}} = resp = Shipstation.Order.upsert_order(params)

      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["orderKey"]) == "0f6bec18-3e89-4881-83aa-f392d84f4c74"
    end
  end

  test "Update multiple orders", context do
    use_cassette "update_orders" do
      orders = [%{ context[:order] | orderKey: "0f6bec18-3e89-4881-83aa-f392d84f4c74" }]
      {:ok, %{body: body}} = resp = Shipstation.Order.upsert_orders(orders)

      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["hasErrors"]) == false
      assert body["results"] |> List.first |> Map.fetch!("orderKey") == "0f6bec18-3e89-4881-83aa-f392d84f4c74"
    end
  end

  test "Create multiple orders", context do
    use_cassette "create_orders" do
      orders = [%{ context[:order] | orderKey: nil }]
      {:ok, %{body: body}} = resp = Shipstation.Order.upsert_orders(orders)

      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["hasErrors"]) == false
      assert body["results"] |> List.first |> Map.fetch!("orderKey") == "0f6bec18-3e89-4881-83aa-f392d84f4c74"
    end
  end

end
