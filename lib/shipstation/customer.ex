defmodule Shipstation.Customer do
  @moduledoc ~s"""
  Manage customers in your account
  """

  @doc ~s"""
  Get a customer by their ID
  """
  @spec get(id :: integer) :: Shipstation.Client.response_type
  def get(id) do
    uri = %{Shipstation.Client.base_uri | path: "/customers/#{id}"}
    Shipstation.Client.call_api(:get, uri, %{})
  end

  @doc ~s"""
  List all matching customers
  """
  @spec list(filter :: Shipstation.Structs.Customer.t) :: Shipstation.Client.response_type
  def list(filter = %Shipstation.Structs.Customer{}) do
    uri = %{Shipstation.Client.base_uri | path: "/customers"}
    Shipstation.Client.call_api(:get, uri, filter)
  end

end
