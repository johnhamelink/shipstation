defmodule Shipstation.Store do
  @moduledoc ~s"""
  Manage Stores under your account
  """

  @doc ~s"""
  Get a store by its ID
  """
  @spec get(id :: integer) :: Shipstation.response_type
  def get(id) do
    uri = %{Shipstation.base_uri | path: "/stores/#{id}"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  List all matching stores
  """
  @spec list(filter :: Shipstation.Structs.Store.t) :: Shipstation.response_type
  def list(filter = %Shipstation.Structs.Store{}) do
    uri = %{Shipstation.base_uri | path: "/stores"}
    Shipstation.call_api(:get, uri, filter)
  end

  @doc ~s"""
  Deactivates the specified store
  """
  @spec deactivate(store_id :: integer) :: Shipstation.response_type
  def deactivate(store_id) do
    uri = %{Shipstation.base_uri | path: "/stores/deactivate"}
    Shipstation.call_api(:post, uri, %{storeId: store_id})
  end

  @doc ~s"""
  Reactivates the specified store
  """
  @spec reactivate(store_id :: integer) :: Shipstation.response_type
  def reactivate(store_id) do
    uri = %{Shipstation.base_uri | path: "/stores/reactivate"}
    Shipstation.call_api(:post, uri, %{storeId: store_id})
  end

  @doc ~s"""
  Lists the marketplaces that can be integrated with ShipStation.
  """
  @spec list_marketplaces() :: Shipstation.response_type
  def list_marketplaces() do
    uri = %{Shipstation.base_uri | path: "/stores/marketplaces"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  Retrieves the refresh status of a given store.
  """
  @spec refresh_status(store_id :: integer) :: Shipstation.response_type
  def refresh_status(store_id) do
    uri = %{Shipstation.base_uri | path: "/stores/getrefreshstatus"}
    Shipstation.call_api(:get, uri, %{storeId: store_id})
  end

  @doc ~s"""
  Initiates a store refresh
  """
  @spec refresh(store_id :: integer, refresh_date :: String.t) :: Shipstation.response_type
  def refresh(store_id, refresh_date) do
    uri = %{Shipstation.base_uri | path: "/stores/refreshstore"}
    Shipstation.call_api(:get, uri, %{storeId: store_id, refreshDate: refresh_date})
  end

end
