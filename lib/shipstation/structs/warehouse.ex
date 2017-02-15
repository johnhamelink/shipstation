defmodule Shipstation.Structs.Warehouse do
  @moduledoc ~s"""
  This struct is used to describe a warehouse
  """
  alias Shipstation.Structs.{Address}

  @type t :: %Shipstation.Structs.Warehouse{
    warehouseId:   integer,
    warehouseName: String.t,
    originAddress: Address.t,
    returnAddress: Address.t,
    createDate:    String.t,
    isDefault:     boolean
  }

  defstruct warehouseId:   0,
            warehouseName: nil,
            originAddress: %Address{},
            returnAddress: %Address{},
            createDate:    nil,
            isDefault:     false
end
