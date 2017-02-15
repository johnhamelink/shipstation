defmodule Shipstation.Order do
  @moduledoc ~s"""
  Manage orders on your account.
  """
  @doc ~s"""
  If the orderKey is specified, the method becomes idempotent and the existing
  order with that key will be updated. Note: Only orders in an open status in
  ShipStation (awaiting_payment,awaiting_shipment, and on_hold) can be updated
  through this method. cancelled and shipped are locked from modification
  through the API.
  """
  @spec upsert(order :: Shipstation.Structs.Order.t) :: Shipstation.response_type
  def upsert(order = %Shipstation.Structs.Order{}) do
    uri = %{Shipstation.base_uri | path: "/orders/createorder"}
    Shipstation.call_api(:post, uri, order)
  end

  @doc ~s"""
  This endpoint can be used to create or update multiple orders in one request.
  If the orderKey is specified in an order, the existing order with that key
  will be updated.

  Note: Only orders in an open status in ShipStation (`awaiting_payment`,
  `awaiting_shipment`, and `on_hold`) can be updated through this method.
  cancelled and shipped are locked from modification through the API.
  """
  @spec upsert(orders :: [Shipstation.Structs.Order.t]) :: Shipstation.response_type
  def upsert(orders) when is_list(orders) do
    uri = %{Shipstation.base_uri | path: "/orders/createorders"}
    Shipstation.call_api(:post, uri, orders)
  end

  @doc ~s"""
  Retrieves a single order from the database.
  """
  @spec get(id :: integer) :: Shipstation.response_type
  def get(id) do
    uri = %{Shipstation.base_uri | path: "/orders/#{id}"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  Removes order from ShipStation's UI. Note this is a "soft" delete action so
  the order will still exist in the database, but will be set to `inactive`
  """
  @spec delete(id :: integer) :: Shipstation.response_type
  def delete(id) do
    uri = %{Shipstation.base_uri | path: "/orders/#{id}"}
    Shipstation.call_api(:delete, uri, %{})
  end

  @doc ~s"""
  List orders without parameters
  """
  @spec list() :: Shipstation.response_type
  def list() do
    uri = %{Shipstation.base_uri | path: "/orders"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  List orders with filter parameters
  """
  @spec list(order_filter :: Shipstation.Structs.OrderFilter.t) :: Shipstation.response_type
  def list(params = %Shipstation.Structs.OrderFilter{}) do
    uri = %{Shipstation.base_uri | path: "/orders"}
    Shipstation.call_api(:get, uri, params)
  end

  ###### TAGS

  @doc ~s"""
  List orders that match the specified status and tag ID.
  """
  @spec list_by_tag(order_status :: String.t, tag_id :: integer, page :: non_neg_integer, page_size :: non_neg_integer) :: Shipstation.response_type
  def list_by_tag(order_status, tag_id, page, page_size) do
    uri = %{Shipstation.base_uri | path: "/orders/listbytag"}
    Shipstation.call_api(:get, uri, %{orderStatus: order_status, tagId: tag_id, page: page, pageSize: page_size})
  end

  @doc ~s"""
  Adds a tag to an order
  """
  @spec add_tag(order_id :: integer, tag_id :: integer) :: Shipstation.response_type
  def add_tag(order_id, tag_id) do
    uri = %{Shipstation.base_uri | path: "/orders/addtag"}
    Shipstation.call_api(:post, uri, %{orderId: order_id, tagId: tag_id})
  end

  @doc ~s"""
  Removes a tag from an order
  """
  @spec remove_tag(order_id :: integer, tag_id :: integer) :: Shipstation.response_type
  def remove_tag(order_id, tag_id) do
    uri = %{Shipstation.base_uri | path: "/orders/removetag"}
    Shipstation.call_api(:post, uri, %{orderId: order_id, tagId: tag_id})
  end

  ###### User Assignment

  @doc ~s"""
  Assigns a user to an order
  """
  @spec assign_user(order_id :: integer, user_id :: integer) :: Shipstation.response_type
  def assign_user(order_id, user_id) when is_number(order_id),
    do: assign_user([order_id], user_id)

  @spec assign_user(order_ids :: [integer], user_id :: integer) :: Shipstation.response_type
  def assign_user(order_ids, user_id) when is_list(order_ids) do
    uri = %{Shipstation.base_uri | path: "/orders/assignuser"}
    Shipstation.call_api(:post, uri, %{orderIds: order_ids, userId: user_id})
  end

  @doc ~s"""
  Unassigns a user from an order.
  """
  @spec unassign_user(order_id :: integer) :: Shipstation.response_type
  def unassign_user(order_id) when is_number(order_id),
    do: unassign_user([order_id])

  @spec unassign_user(order_ids :: [integer]) :: Shipstation.response_type
  def unassign_user(order_ids) when is_list(order_ids) do
    uri = %{Shipstation.base_uri | path: "/orders/unassignuser"}
    Shipstation.call_api(:post, uri, %{orderIds: order_ids})
  end

  ###### Shipping

  @doc ~s"""
  Creates a shipping label for a given order.

  The `labelData` field returned in the response is a base64 encoded PDF value.
  Simply decode and save the output as a PDF file to retrieve a printable label.
  """
  @spec create_label(order :: Shipstation.Structs.Label.t) :: Shipstation.response_type
  def create_label(params = %Shipstation.Structs.Label{}) do
    uri = %{Shipstation.base_uri | path: "/orders/createlabelfororder"}
    Shipstation.call_api(:post, uri, params)
  end

  @doc ~s"""
  This method will change the status of the given order to On Hold until the
  date specified, when the status will automatically change to Awaiting
  Shipment.
  """
  @spec hold_until(order_id :: integer, hold_until_date :: String.t) :: Shipstation.response_type
  def hold_until(order_id, hold_until_date) do
    uri = %{Shipstation.base_uri | path: "/orders/holduntil"}
    Shipstation.call_api(:post, uri, %{orderId: order_id, holdUntilDate: hold_until_date})
  end

  @doc ~s"""
  This method will change the status of the given order from On Hold to Awaiting
  Shipment. This endpoint is used when a `holdUntil` Date is attached to an order.
  """
  @spec restore_from_on_hold(order_id :: integer) :: Shipstation.response_type
  def restore_from_on_hold(order_id) do
    uri = %{Shipstation.base_uri | path: "/orders/restorefromhold"}
    Shipstation.call_api(:post, uri, %{orderId: order_id})
  end

  @doc ~s"""
  Marks an order as shipped without creating a label in ShipStation.
  """
  @spec mark_as_shipped(params :: Shipstation.Structs.OrderShipped.t) :: Shipstation.response_type
  def mark_as_shipped(params = %Shipstation.Structs.OrderShipped{}) do
    uri = %{Shipstation.base_uri | path: "/orders/markasshipped"}
    Shipstation.call_api(:post, uri, params)
  end

end
