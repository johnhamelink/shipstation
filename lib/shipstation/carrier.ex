defmodule Shipstation.Carrier do

    @doc ~s"""
      Lists all shipping providers connected to this account.
    """
    def list() do
      uri = %{Shipstation.base_uri | path: "/carriers"}
      Shipstation.call_api(:get, uri, %{})
    end

    @doc ~s"""
      Retrieves the shipping carrier account details for the specified
      carrierCode. Use this method to determine a carrier's account balance.
    """
    def get(carrier) do
      uri = %{Shipstation.base_uri | path: "/carriers/getcarrier"}
      Shipstation.call_api(:get, uri, %{carrierCode: carrier})
    end

    @doc ~s"""
    Adds funds to a carrier account using the payment information on
    file.
    """
    def add_funds(carrier, amount) do
      uri = %{Shipstation.base_uri | path: "/carriers/addfunds"}
      Shipstation.call_api(:post, uri, %{carrierCode: carrier, amount: amount})
    end

    @doc ~s"""
    Retrieves a list of packages for the specified carrier
    """
    def list_packages(carrier) do
      uri = %{Shipstation.base_uri | path: "/carriers/listpackages"}
      Shipstation.call_api(:get, uri, %{carrierCode: carrier})
    end

    @doc ~s"""
    Retrieves the list of available shipping services provided by the specified carrier
    """
    def list_services(carrier) do
      uri = %{Shipstation.base_uri | path: "/carriers/listservices"}
      Shipstation.call_api(:get, uri, %{carrierCode: carrier})
    end

end
