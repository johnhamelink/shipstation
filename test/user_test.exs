defmodule Shipstation.UserTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Shipstation.Customer

  setup_all do
    HTTPoison.start
  end

  test "List all users" do
    use_cassette "user_list" do
      {:ok, %{body: body}} = resp = Shipstation.User.list(false)
      assert {:ok, %{status_code: 200}} = resp

      assert get_in(body, ["name"]) == "Shipping Employee 1"
    end
  end

end
