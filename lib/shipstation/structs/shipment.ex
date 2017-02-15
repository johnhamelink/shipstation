defmodule Shipstation.Structs.Shipment do
  @moduledoc ~s"""
  This struct is used for describing a shipment
  """
  alias Shipstation.Structs.{Weight, Dimension}

  @type t :: %Shipstation.Structs.Shipment{
    carrierCode:    String.t,
    serviceCode:    String.t,
    packageCode:    String.t,
    fromPostalCode: String.t,
    toState:        String.t,
    toCountry:      String.t,
    toPostalCode:   String.t,
    toCity:         String.t,
    weight:         Weight.t,
    dimensions:     Dimension.t,
    confirmation:   String.t,
    residential:    boolean
  }

  defstruct carrierCode:    nil,
            serviceCode:    nil,
            packageCode:    nil,
            fromPostalCode: nil,
            toState:        nil,
            toCountry:      nil,
            toPostalCode:   nil,
            toCity:         nil,
            weight:         %Weight{},
            dimensions:     %Dimension{},
            confirmation:   nil,
            residential:    false
end
