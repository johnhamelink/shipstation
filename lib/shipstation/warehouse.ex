defmodule Shipstation.Warehouse do
  @moduledoc ~s"""
  Manage warehouses in your account
  """
  @doc ~s"""
  Returns a list of active Ship From Locations (formerly known as warehouses) on
  the ShipStation account. Warehouses are now called "Ship From Locations" in
  the UI.
  """
  @spec get(warehouse_id :: integer) :: Shipstation.Client.response_type
  def get(warehouse_id) do
    uri = %{Shipstation.Client.base_uri | path: "/warehouses/#{warehouse_id}"}
    Shipstation.Client.call_api(:get, uri, %{})
  end

  @doc ~s"""
  Retrieves a list of your Ship From Locations (formerly known as warehouses).
  """
  @spec list() :: Shipstation.Client.response_type
  def list() do
    uri = %{Shipstation.Client.base_uri | path: "/warehouses"}
    Shipstation.Client.call_api(:get, uri, %{})
  end

  @doc ~s"""
  Updates an existing Ship From Location (formerly known as warehouse). This
  call does not currently support partial updates. The entire resource must be
  provided in the body of the request. If a "returnAddress" object is not
  specified, your "originAddress" will be used as your "returnAddress".
  """
  @spec update(warehouse_id :: integer, warehouse :: Shipstation.Structs.Warehouse.t) :: Shipstation.Client.response_type
  def update(warehouse_id, warehouse) do
    uri = %{Shipstation.Client.base_uri | path: "/warehouses/#{warehouse_id}"}
    Shipstation.Client.call_api(:put, uri, warehouse)
  end

  @doc ~s"""
  Adds a Ship From Location (formerly known as warehouse) to your account.
  """
  @spec create(warehouse :: Shipstation.Structs.Warehouse.t) :: Shipstation.Client.response_type
  def create(warehouse) do
    uri = %{Shipstation.Client.base_uri | path: "/warehouses/createwarehouse"}
    Shipstation.Client.call_api(:post, uri, warehouse)
  end

end
