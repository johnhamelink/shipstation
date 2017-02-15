defmodule Shipstation.Shipment do
  @moduledoc ~s"""
  Manage shipments in your account
  """
  @doc ~s"""
  List all shipments
  """
  @spec list() :: Shipstation.response_type
  def list() do
    uri = %{Shipstation.base_uri | path: "/shipments"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  List all matching shipments
  """
  @spec list(filter :: Shipstation.Structs.ShipmentFilter.t) :: Shipstation.response_type
  def list(filter = %Shipstation.Structs.ShipmentFilter{}) do
    uri = %{Shipstation.base_uri | path: "/shipments"}
    Shipstation.call_api(:get, uri, filter)
  end

  @doc ~s"""
  Retrieves shipping rates for the specified shipping details.
  """
  @spec get_rates(params :: Shipstation.Structs.Shipment.t) :: Shipstation.response_type
  def get_rates(params = %Shipstation.Structs.Shipment{}) do
    uri = %{Shipstation.base_uri | path: "/shipments/getrates"}
    Shipstation.call_api(:post, uri, params)
  end

  @doc ~s"""
  Voids the specified lable by `shipmentId`.
  """
  @spec void_label(shipment_id :: integer) :: Shipstation.response_type
  def void_label(shipment_id) do
    uri = %{Shipstation.base_uri | path: "/shipments/voidlabel"}
    Shipstation.call_api(:post, uri, %{shipmentId: shipment_id})
  end

end
