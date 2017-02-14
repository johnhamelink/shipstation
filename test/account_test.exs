defmodule Shipstation.AccountTest do
  use ExUnit.Case, async: true
  doctest Shipstation.Account

  test "Register User" do

    resp =
      %Shipstation.Account{
        "firstName":                 "John",
        "lastName":                  "Smith",
        "email":                     "jsmithtest@gmail.com",
        "password":                  "testpw1234",
        "shippingOriginCountryCode": "US",
        "companyName":               "Droid Repair LLC",
        "addr1":                     "542 Midichlorian Rd.",
        "addr2":                     "",
        "city":                      "Austin",
        "state":                     "TX",
        "zip":                       "78703",
        "countryCode":               "US",
        "phone":                     "5124111234"
      }
      |> Shipstation.Account.register

    assert {:ok, %{status_code: 200}} = resp
  end

  test "List tags" do
    {:ok, %{body: body}} = resp = Shipstation.Account.list_tags
    assert {:ok, %{status_code: 200}} = resp

    all = fn :get, data, next -> Enum.map(data, next) end
    assert (Kernel.get_in(body, [all, "name"]) |> Enum.sort) == [
      "Backorder", "Canada", "Fragile", "Repeat Buyer"]
  end

end
