defmodule Shipstation.Filters.Fulfillment do
  @moduledoc ~s"""
  Parameters used when filtering fulfillments
  """

  defstruct orderId: nil,
            orderNumber: nil,
            trackingNumber: nil,
            receiptName: nil,
            createDateStart: nil,
            createDateEnd: nil,
            shipDateStart: nil,
            shipDateEnd: nil,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100

end
