defmodule Shipstation.Structs.InsuranceOption do
  @moduledoc ~s"""
  This struct is used for describing the insurance option required for the
  delivery.
  """

  @type t :: %Shipstation.Structs.InsuranceOption{
    provider: String.t,
    insureShipment: boolean,
    insuredValue: float
  }

  defstruct provider: nil,
            insureShipment: false,
            insuredValue: 0
end
