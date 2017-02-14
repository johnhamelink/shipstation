defmodule Shipstation.Carrier do
  @moduledoc ~s"""
  Manage carriers and the accounts you have with them.
  """

  @doc ~s"""
    Lists all shipping providers connected to this account.
  """
  @spec list() :: Shipstation.response_type
  def list() do
    uri = %{Shipstation.base_uri | path: "/carriers"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
    Retrieves the shipping carrier account details for the specified
    carrierCode. Use this method to determine a carrier's account balance.
  """
  @spec get(carrier :: String.t) :: Shipstation.response_type
  def get(carrier) do
    uri = %{Shipstation.base_uri | path: "/carriers/getcarrier"}
    Shipstation.call_api(:get, uri, %{carrierCode: carrier})
  end

  @doc ~s"""
  Adds funds to a carrier account using the payment information on
  file.
  """
  @spec add_funds(carrier :: String.t, amount :: float) :: Shipstation.response_type
  def add_funds(carrier, amount) do
    uri = %{Shipstation.base_uri | path: "/carriers/addfunds"}
    Shipstation.call_api(:post, uri, %{carrierCode: carrier, amount: amount})
  end

  @doc ~s"""
  Retrieves a list of packages for the specified carrier
  """
  @spec list_packages(carrier :: String.t) :: Shipstation.response_type
  def list_packages(carrier) do
    uri = %{Shipstation.base_uri | path: "/carriers/listpackages"}
    Shipstation.call_api(:get, uri, %{carrierCode: carrier})
  end

  @doc ~s"""
  Retrieves the list of available shipping services provided by the specified carrier
  """
  @spec list_services(carrier :: String.t) :: Shipstation.response_type
  def list_services(carrier) do
    uri = %{Shipstation.base_uri | path: "/carriers/listservices"}
    Shipstation.call_api(:get, uri, %{carrierCode: carrier})
  end

end
