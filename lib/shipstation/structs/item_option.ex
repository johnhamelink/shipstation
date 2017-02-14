defmodule Shipstation.Structs.ItemOption do
  @moduledoc ~s"""
  This struct is used for describing options about an Order Item
  """

  @type t :: %Shipstation.Structs.ItemOption{
    name: String.t,
    value: String.t
  }

  defstruct name: nil,
            value: nil
end
