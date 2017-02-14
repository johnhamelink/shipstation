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

  defstruct orderItemId:       0,
            lineItemKey:       nil,
            sku:               nil,
            name:              nil,
            imageUrl:          nil,
            weight:            %Shipstation.Structs.Weight{},
            quantity:          0,
            unitPrice:         0,
            taxAmount:         0,
            shippingAmount:    0,
            warehouseLocation: nil,
            options:           [],
            productId:         0,
            fulfillmentSku:    nil,
            adjustment:        false,
            upc:               nil,
            createDate:        nil,
            modifyDate:        nil
end
