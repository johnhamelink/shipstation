defmodule Shipstation.Structs.OrderShipped do
  @moduledoc ~s"""
  This struct is used when marking an order as shipped
  """

  @type t :: %Shipstation.Structs.OrderShipped{
    orderId: integer,
    carrierCode: String.t,
    shipDate: String.t,
    trackingNumber: String.t,
    notifyCustomer: boolean,
    notifySalesChannel: boolean
  }

  defstruct orderId: 0,
            carrierCode: nil,
            shipDate: nil,
            trackingNumber: nil,
            notifyCustomer: false,
            notifySalesChannel: false
end
