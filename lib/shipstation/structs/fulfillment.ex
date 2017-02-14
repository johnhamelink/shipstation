defmodule Shipstation.Structs.Fulfillment do
  @moduledoc ~s"""
  Parameters used when filtering fulfillments
  """

  @type t :: %Shipstation.Structs.Fulfillment{
    fulfillmentId: integer,
    orderId: integer,
    orderNumber: String.t,
    trackingNumber: String.t,
    recipientName: String.t,
    createDateStart: String.t,
    createDateEnd: String.t,
    shipDateStart: String.t,
    shipDateEnd: String.t,
    sortBy: String.t,
    sortDir: String.t,
    page: non_neg_integer,
    pageSize: non_neg_integer
  }

  defstruct fulfillmentId: nil,
            orderId: nil,
            orderNumber: nil,
            trackingNumber: nil,
            recipientName: nil,
            createDateStart: nil,
            createDateEnd: nil,
            shipDateStart: nil,
            shipDateEnd: nil,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100

end
