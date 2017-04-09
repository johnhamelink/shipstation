defmodule Shipstation.Serializer do
  @moduledoc """
  This function is used to strip out nils in deeply-nested data.
  """

  def deep_consolidate(body = %Shipstation.Structs.Order{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.OrderItem{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Account{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Address{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.AdvancedOption{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Customer{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.CustomsItem{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Dimension{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Fulfillment{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.InsuranceOption{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.InternationalOption{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.ItemOption{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Label{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.OrderShipped{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Product{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.ProductCategory{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.ProductFilter{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.ProductTag{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Shipment{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.ShipmentFilter{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Store{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Warehouse{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Webhook{}),
  do: do_deep_consolidate(body)

  def deep_consolidate(body = %Shipstation.Structs.Weight{}),
  do: do_deep_consolidate(body)

  # When we're consolidating a list, just loop through it
  def deep_consolidate(items) when is_list(items),
  do: Enum.map(items, &deep_consolidate/1)

  # If it's not a whitelisted map or a list then skip
  def deep_consolidate(thing), do: thing

  @doc """
  For each key/value pair in a map, filter out the ones with a nil value,
  then for ones which are of type Map, recurse down and return the result.
  """
  def do_deep_consolidate(body) when is_map(body) do
    body
    |> Map.from_struct
    |> Enum.filter_map(
      fn({key, value}) -> not is_nil(value) end,
      fn(item = {key, value}) ->
        # Map
        cond do
          is_map(value) or is_list(value) ->
            {key, deep_consolidate(value)}
          true ->
            {key, value}
        end
      end
    )
    |> Enum.into(%{})
  end
end
