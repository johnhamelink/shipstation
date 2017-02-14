defmodule Shipstation.CustomerTest do
  use ExUnit.Case, async: true
  doctest Shipstation.Customer

  test "Get Customer" do
    {:ok, %{body: body}} = resp = Shipstation.Customer.get(12345678)
    assert {:ok, %{status_code: 200}} = resp

    all = fn :get, data, next -> Enum.map(data, next) end
    assert get_in(body, ["marketplaceUsernames", all, "username"]) |> Enum.sort == [
      "camtheman@gmail.com",
      "camtheman@gmail.com",
      "supercam@example.com"]
  end

  test "List Customers" do
    params = %Shipstation.Customer.Filter{
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
