defmodule Shipstation.CustomerTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Customer

  setup_all do
    HTTPoison.start
  end

  test "Get Customer" do
    use_cassette "customer_get" do
      {:ok, %{body: body}} = resp = Shipstation.Customer.get(12345678)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert get_in(body, ["marketplaceUsernames", all, "username"]) |> Enum.sort == [
        "camtheman@gmail.com",
        "camtheman@gmail.com",
        "supercam@example.com"]
    end
  end

  test "List Customers" do
    use_cassette "list_customers" do
      params = %Shipstation.Filters.Customer{
        stateCode: nil,
        countryCode: nil,
        marketplaceId: nil,
        tagId: nil,
        sortBy: nil,
        sortDir: nil,
        page: 1,
        pageSize: 100
      }
      {:ok, %{body: body}} = resp = Shipstation.Customer.list(params)
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert get_in(body, ["customers", all, "email"]) |> Enum.sort == [
        "boknows@example.com", "supermancam@example.com"]
    end
  end

end
