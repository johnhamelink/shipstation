defmodule Shipstation.Order do
  @moduledoc ~s"""
  Manage orders on your account.
  """

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
  Adds a tag to an order
  """
  @spec add_tag(order_id :: integer, tag_id :: integer) :: Shipstation.response_type
  def add_tag(order_id, tag_id) do
    uri = %{Shipstation.base_uri | path: "/orders/addtag"}
    Shipstation.call_api(:post, uri, %{orderId: order_id, tagId: tag_id})
  end

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
  Creates a shipping label for a given order.

  The `labelData` field returned in the response is a base64 encoded PDF value.
  Simply decode and save the output as a PDF file to retrieve a printable label.
  """
  @spec create_label(order :: Shipstation.Structs.Order.t) :: Shipstation.response_type
  def create_label(params = %Shipstation.Structs.Order{}) do
    uri = %{Shipstation.base_uri | path: "/orders/createlabelfororder"}
    Shipstation.call_api(:post, uri, params)
  end

end
