defmodule Shipstation.WarehouseTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Warehouse

  setup_all do
    HTTPoison.start
  end

  test "List Warehouses" do
    use_cassette "warehouse_list" do
      {:ok, %{body: body}} = resp = Shipstation.Warehouse.list
      all = fn :get, data, next -> Enum.map(data, next) end

      assert {:ok, %{status_code: 200}} = resp
      assert Enum.sort(get_in(body, [all, "warehouseName"])) == ["Austin", "Main warehouse"]
    end
  end

  test "Get Warehouse" do
    use_cassette "warehouse_get" do
      {:ok, %{body: body}} = resp = Shipstation.Warehouse.get(12_345_678)
      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["warehouseName"]) == "API Ship From Location"
    end
  end

  test "Update Warehouse" do
    use_cassette "warehouse_update" do
      params = %Shipstation.Structs.Warehouse{
        warehouseId: 12_345,
        warehouseName: "API Ship From Location",
        originAddress: %Shipstation.Structs.Address{
          name: "API Warehouse",
          company: "ShipStation",
          street1: "2815 Exposition Blvd",
          street2: nil,
          street3: nil,
          city: "Austin",
          state: "TX",
          postalCode: "78703",
          country: "US",
          phone: "512-555-5555",
          residential: true,
          addressVerified: nil
        },
        returnAddress: %Shipstation.Structs.Address{
          name: "API Warehouse",
          company: "ShipStation",
          street1: "2815 Exposition Blvd",
          street2: nil,
          street3: nil,
          city: "Austin",
          state: "TX",
          postalCode: "78703",
          country: "US",
          phone: "512-555-5555",
          residential: true,
          addressVerified: nil
        },
        createDate: "2015-07-02T08:38:31.4870000",
        isDefault: true
      }

      {:ok, %{body: body}} = resp = Shipstation.Warehouse.update(12_345_678, params)
      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["warehouseName"]) == "API Ship From Location"
    end
  end

  test "Create Warehouse" do
    use_cassette "warehouse_create" do
      params = %Shipstation.Structs.Warehouse{
        warehouseName: "API Ship From Location",
        originAddress: %Shipstation.Structs.Address{
          name: "API Warehouse",
          company: "ShipStation",
          street1: "2815 Exposition Blvd",
          street2: nil,
          street3: nil,
          city: "Austin",
          state: "TX",
          postalCode: "78703",
          country: "US",
          phone: "512-555-5555",
          residential: true,
          addressVerified: nil
        },
        returnAddress: nil,
        isDefault: true
      }

      {:ok, %{body: body}} = resp = Shipstation.Warehouse.create(params)
      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["warehouseId"]) == 17_977
    end
  end
end
