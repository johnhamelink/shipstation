defmodule Shipstation.AccountTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Account

  setup_all do
    HTTPoison.start
  end

  test "Register User" do
    use_cassette "register_user" do
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
  end

  test "List tags" do
    use_cassette "list_tags" do
      {:ok, %{body: body}} = resp = Shipstation.Account.list_tags
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert (Kernel.get_in(body, [all, "name"]) |> Enum.sort) == [
        "Backorder", "Canada", "Fragile", "Repeat Buyer"]
    end
  end

end
