defmodule Shipstation.Customer do
  @moduledoc ~s"""
  Manage customers in your account
  """

  @doc ~s"""
  Get a customer by their ID
  """
  @spec get(id :: integer) :: Shipstation.response_type
  def get(id) do
    uri = %{Shipstation.base_uri | path: "/customers/#{id}"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  List all matching customers
  """
  @spec list(filter :: Shipstation.Filters.Customer.t) :: Shipstation.response_type
  def list(filter = %Shipstation.Filters.Customer{}) do
    uri = %{Shipstation.base_uri | path: "/customers"}
    Shipstation.call_api(:get, uri, filter)
  end

end
