defmodule Shipstation.Order do

  @doc ~s"""
  Retrieves a single order from the database.
  """
  def get(id) do
    uri = %{Shipstation.base_uri | path: "/orders/#{id}"}
    Shipstation.call_api(:get, uri, %{})
  end

  @doc ~s"""
  Removes order from ShipStation's UI. Note this is a "soft" delete action so
  the order will still exist in the database, but will be set to `inactive`
  """
  def delete(id) do
    uri = %{Shipstation.base_uri | path: "/orders/#{id}"}
    Shipstation.call_api(:delete, uri, %{})
  end

  @doc ~s"""
  Adds a tag to an order
  """
  def add_tag(order_id, tag_id) do
    uri = %{Shipstation.base_uri | path: "/orders/addtag"}
    Shipstation.call_api(:post, uri, %{orderId: order_id, tagId: tag_id})
  end

  @doc ~s"""
  Assigns a user to an order
  """
  def assign_user(order_id, user_id) when is_number(order_id),
    do: assign_user([order_id], user_id)

  def assign_user(order_ids, user_id) when is_list(order_ids) do
    uri = %{Shipstation.base_uri | path: "/orders/assignuser"}
    Shipstation.call_api(:post, uri, %{orderIds: order_ids, userId: user_id})
  end


  @doc ~s"""
  Creates a shipping label for a given order.

  The `labelData` field returned in the response is a base64 encoded PDF value.
  Simply decode and save the output as a PDF file to retrieve a printable label.
  """
  def create_label(params = %Shipstation.Structs.Order{}) do
    uri = %{Shipstation.base_uri | path: "/orders/createlabelfororder"}
    Shipstation.call_api(:post, uri, params)
  end

end
