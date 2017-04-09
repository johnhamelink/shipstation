defmodule Shipstation.Structs.OrderItem do
  @moduledoc ~s"""
  This struct is used for describing items inside an order
  """

  alias Shipstation.Structs.{Weight, ItemOption}

  @type t :: %Shipstation.Structs.OrderItem{
    orderItemId:       integer,
    lineItemKey:       String.t,
    sku:               String.t,
    name:              String.t,
    imageUrl:          String.t,
    weight:            Weight.t,
    quantity:          non_neg_integer,
    unitPrice:         float,
    taxAmount:         float,
    shippingAmount:    float,
    warehouseLocation: String.t,
    options:           [ItemOption.t],
    productId:         integer,
    fulfillmentSku:    String.t,
    adjustment:        boolean,
    upc:               String.t,
    createDate:        String.t,
    modifyDate:        String.t
  }

  defstruct orderItemId:       nil,
            lineItemKey:       nil,
            sku:               nil,
            name:              nil,
            imageUrl:          nil,
            weight:            nil,
            quantity:          nil,
            unitPrice:         nil,
            taxAmount:         nil,
            shippingAmount:    nil,
            warehouseLocation: nil,
            options:           [],
            productId:         nil,
            fulfillmentSku:    nil,
            adjustment:        false,
            upc:               nil,
            createDate:        nil,
            modifyDate:        nil
end
