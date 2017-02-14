defmodule Shipstation.Structs.Dimension do
  @moduledoc ~s"""
  This struct is used for describing weight
  """

  @type t :: %Shipstation.Structs.Dimension{
    length: float,
    width: float,
    height: float,
    units: String.t
  }

  defstruct length: 0,
            width: 0,
            height: 0,
            units: nil
end
