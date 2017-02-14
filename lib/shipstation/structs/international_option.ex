defmodule Shipstation.Structs.InternationalOption do
  @moduledoc ~s"""
  This struct is used to define international options which may be required on
  an order.
  """

  @type t :: %Shipstation.Structs.InternationalOption{
    contents: String.t,
    customsItems: [Shipstation.Structs.CustomsItem.t],
    nonDelivery: String.t
  }

  defstruct contents: nil,
            customsItems: [],
            nonDelivery: nil
end
