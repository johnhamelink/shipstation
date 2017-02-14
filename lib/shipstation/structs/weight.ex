defmodule Shipstation.Structs.Weight do
  @moduledoc ~s"""
  This struct is used for describing weight
  """

  @type t :: %Shipstation.Structs.Weight{
    value: float,
    units: String.t
  }

  defstruct value: 0,
            units: "pounds"
end
