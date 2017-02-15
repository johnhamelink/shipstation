defmodule Shipstation.ShipmentTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Customer

  setup_all do
    HTTPoison.start
  end

  test "List all shipments" do
    use_cassette "list_all_shipments" do
      {:ok, %{body: body}} = resp = Shipstation.Shipment.list
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(get_in(body, ["shipments", all, "shipmentId"])) == [33_974_373, 33_974_374]
    end
  end

  test "List Matching Shipments" do
    use_cassette "list_matching_shipments" do
      params = %Shipstation.Structs.ShipmentFilter{
        recipientName: nil,
        recipientCountryCode: nil,
        orderNumber: nil,
        orderId: nil,
        carrierCode: nil,
        serviceCode: nil,
        trackingNumber: nil,
        createDateStart: "2015-01-01 00:00:00",
        createDateEnd: "2015-01-08 00:00:00",
        shipDateStart: "2015-01-01",
        shipDateEnd: "2015-01-08",
        voidDateStart: "2015-01-01 00:00:00",
        voidDateEnd: "2015-01-08 00:00:00",
        includeShipmentItems: false,
        sortBy: "ShipDate",
        sortDir: "ASC",
        page: 1,
        pageSize: 100
      }
      {:ok, %{body: body}} = resp = Shipstation.Shipment.list(params)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(get_in(body, ["shipments", all, "shipmentId"])) == [33_974_373, 33_974_374]
    end
  end

  test "Get Shipment Rates" do
    use_cassette "get_shipment_rates" do
      params = %Shipstation.Structs.Shipment{
        carrierCode: "fedex",
        serviceCode: nil,
        packageCode: nil,
        fromPostalCode: "78703",
        toState: "DC",
        toCountry: "US",
        toPostalCode: "20500",
        toCity: "Washington",
        weight: %Shipstation.Structs.Weight{
          value: 3,
          units: "ounces"
        },
        dimensions: %Shipstation.Structs.Dimension{
          units: "inches",
          length: 7,
          width: 5,
          height: 6
        },
        confirmation: "delivery",
        residential: false
      }

      {:ok, %{body: body}} = resp = Shipstation.Shipment.get_rates(params)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(get_in(body, [all, "serviceName"])) == [
        "FedEx 2Day®",
        "FedEx 2Day® A.M.",
        "FedEx Express Saver®",
        "FedEx First Overnight®",
        "FedEx Ground®",
        "FedEx Priority Overnight®",
        "FedEx Standard Overnight®"
      ]
    end
  end

  test "void shipment label" do
    use_cassette "void_shipment_label" do
      {:ok, %{body: body}} = resp = Shipstation.Shipment.void_label(12_345)
      assert {:ok, %{status_code: 200}} = resp
      assert body == %{"approved" => true, "message" => "Label voided successfully"}
    end
  end

end
