defmodule Shipstation.Structs.CustomsItem do
  @moduledoc ~s"""
  This struct is used for describing weight
  """

  @type t :: %Shipstation.Structs.CustomsItem{
    customsItemId: String.t,
    description: String.t,
    quantity: non_neg_integer,
    value: float,
    harmonizedTarriffCode: String.t,
    countryOfOrigin: String.t
  }

  defstruct customsItemId: nil,
            description: nil,
            quantity: 0,
            value: 0,
            harmonizedTarriffCode: nil,
            countryOfOrigin: nil
end
