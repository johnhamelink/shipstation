defmodule Shipstation.CarrierTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Carrier

  setup_all do
    HTTPoison.start
  end

  test "List Carriers" do
    use_cassette "list_carriers" do
      {:ok, %{body: body}} = resp = Shipstation.Carrier.list
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(Kernel.get_in(body, [all, "accountNumber"])) == [
        "297929999", "913999", "ABCR80", "SS123", "fe71c33f"]
    end
  end

  test "Get Carrier" do
    use_cassette "get_carrier" do
      {:ok, %{body: body}} = resp = Shipstation.Carrier.get("stamps_com")
      assert {:ok, %{status_code: 200}} = resp

      assert %{
        "name" => "Stamps.com",
        "code" => "stamps_com",
        "accountNumber" => "SS123",
        "requiresFundedAccount" => true,
        "balance" => 24.14} == body
    end
  end

  test "Add Funds" do
    use_cassette "add_funds" do
      {:ok, %{body: body}} = resp = Shipstation.Carrier.add_funds("fedex", "20.00")
      assert {:ok, %{status_code: 200}} = resp

      assert %{
        "name" => "Stamps.com",
        "code" => "stamps_com",
        "accountNumber" => "SS123",
        "requiresFundedAccount" => true,
        "balance" => 24.14} == body
    end
  end

  test "List Packages" do
    use_cassette "list_packages" do
      {:ok, %{body: body}} = resp = Shipstation.Carrier.list_packages("fedex")
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(Kernel.get_in(body, [all, "name"])) == [
        "Cubic", "DVD Flat Rate Box", "Flat Rate Envelope",
        "Flat Rate Legal Envelope", "Flat Rate Padded Envelope",
        "Large Envelope or Flat", "Large Flat Rate Box",
        "Large Package (any side > 12\")", "Large Video Flat Rate Box",
        "Letter", "Medium Flat Rate Box", "Package", "Regional Rate Box A",
        "Regional Rate Box B", "Regional Rate Box C", "Small Flat Rate Box",
        "Thick Envelope"]
    end
  end

  test "List Services" do
    use_cassette "list_services" do
      {:ok, %{body: body}} = resp = Shipstation.Carrier.list_services("fedex")
      assert {:ok, %{status_code: 200}} = resp

      all = fn :get, data, next -> Enum.map(data, next) end
      assert Enum.sort(Kernel.get_in(body, [all, "code"])) == [
        "fedex_1_day_freight", "fedex_2_day_freight", "fedex_2day",
        "fedex_2day_am", "fedex_3_day_freight", "fedex_europe_first",
        "fedex_express_saver", "fedex_first_overnight",
        "fedex_first_overnight_freight", "fedex_ground",
        "fedex_ground_international", "fedex_home_delivery",
        "fedex_international_economy", "fedex_international_economy_freight",
        "fedex_international_first", "fedex_international_priority",
        "fedex_international_priority_freight", "fedex_priority_overnight",
        "fedex_standard_overnight"]
    end
  end

end
