defmodule Shipstation.Structs.ShipmentFilter do
  @moduledoc ~s"""
  This struct is used when searching for shipments
  """
  @type t :: %Shipstation.Structs.ShipmentFilter{
    recipientName: String.t,
    recipientCountryCode: String.t,
    orderNumber: String.t,
    orderId: String.t,
    carrierCode: String.t,
    serviceCode: String.t,
    trackingNumber: String.t,
    createDateStart: String.t,
    createDateEnd: String.t,
    shipDateStart: String.t,
    shipDateEnd: String.t,
    voidDateStart: String.t,
    voidDateEnd: String.t,
    includeShipmentItems: boolean,
    sortBy: String.t,
    sortDir: String.t,
    page: non_neg_integer,
    pageSize: non_neg_integer
  }

  defstruct recipientName: nil,
            recipientCountryCode: nil,
            orderNumber: nil,
            orderId: nil,
            carrierCode: nil,
            serviceCode: nil,
            trackingNumber: nil,
            createDateStart: nil,
            createDateEnd: nil,
            shipDateStart: nil,
            shipDateEnd: nil,
            voidDateStart: nil,
            voidDateEnd: nil,
            includeShipmentItems: false,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100

end
