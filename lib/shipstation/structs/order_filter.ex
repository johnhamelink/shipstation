defmodule Shipstation.Structs.OrderFilter do
  @moduledoc ~s"""
  Parameters used when searching through orders
  """
  @type t :: %Shipstation.Structs.OrderFilter{
    customerName: String.t,
    itemKeyword: String.t,
    createDateStart: String.t,
    createDateEnd: String.t,
    modifyDateStart: String.t,
    modifyDateEnd: String.t,
    orderDateStart: String.t,
    orderDateEnd: String.t,
    orderNumber: String.t,
    orderStatus: String.t,
    paymentDateStart: String.t,
    paymentDateEnd: String.t,
    storeId: String.t,
    sortBy: String.t,
    sortDir: String.t,
    page: non_neg_integer,
    pageSize: non_neg_integer
  }

  defstruct customerName: nil,
            itemKeyword: nil,
            createDateStart: nil,
            createDateEnd: nil,
            modifyDateStart: nil,
            modifyDateEnd: nil,
            orderDateStart: nil,
            orderDateEnd: nil,
            orderNumber: nil,
            orderStatus: nil,
            paymentDateStart: nil,
            paymentDateEnd: nil,
            storeId: nil,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100
end
