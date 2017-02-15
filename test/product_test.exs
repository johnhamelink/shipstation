defmodule Shipstation.ProductTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Product

  setup_all do
    HTTPoison.start
  end

  test "Get product" do
    use_cassette "product_get" do
      {:ok, %{body: body}} = resp = Shipstation.Product.get(12_345_678)
      assert {:ok, %{status_code: 200}} = resp
      assert get_in(body, ["productId"]) == 12_345_678
    end
  end

  test "List all products" do
    use_cassette "product_list" do
      {:ok, %{body: body}} = resp = Shipstation.Product.list

      all = fn :get, data, next -> Enum.map(data, next) end
      assert {:ok, %{status_code: 200}} = resp
      assert Enum.sort(get_in(body, ["products", all, "name"])) == ["Coffee Mug", "Product Name 123"]
    end
  end

  test "List matching products" do
    use_cassette "product_list_matching" do
      params = %Shipstation.Structs.ProductFilter{
        sku: nil,
        name: nil,
        productCategoryId: nil,
        productTypeId: nil,
        tagId: nil,
        startDate: nil,
        endDate: nil,
        sortBy: nil,
        sortDir: "ASC",
        page: 1,
        pageSize: 100,
        showInactive: false
      }
      {:ok, %{body: body}} = resp = Shipstation.Product.list(params)

      all = fn :get, data, next -> Enum.map(data, next) end
      assert {:ok, %{status_code: 200}} = resp
      assert Enum.sort(get_in(body, ["products", all, "name"])) == ["Coffee Mug", "Product Name 123"]
    end
  end

  test "Update product" do
    use_cassette "product_update" do
      params = %Shipstation.Structs.Product{
        productId: 123456789,
        sku: "",
        name: "Beautiful",
        price: 0,
        defaultCost: nil,
        length: nil,
        width: nil,
        height: nil,
        weightOz: nil,
        internalNotes: nil,
        fulfillmentSku: nil,
        active: true,
        productCategory: nil,
        productType: nil,
        warehouseLocation: nil,
        defaultCarrierCode: nil,
        defaultServiceCode: nil,
        defaultPackageCode: nil,
        defaultIntlCarrierCode: nil,
        defaultIntlServiceCode: nil,
        defaultIntlPackageCode: nil,
        defaultConfirmation: nil,
        defaultIntlConfirmation: nil,
        customsDescription: nil,
        customsValue: nil,
        customsTariffNo: nil,
        customsCountryCode: nil,
        noCustoms: nil,
        tags: nil
      }

      {:ok, %{body: body}} = Shipstation.Product.update(12_345_678, params)
      assert body == %{"message" => "The requested product has been updated", "success" => true}
    end
  end

end
