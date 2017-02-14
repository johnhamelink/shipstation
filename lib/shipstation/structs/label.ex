defmodule Shipstation.Structs.Label do
  alias Shipstation.Structs.{Weight, Dimension, InsuranceOption, AdvancedOption, InternationalOption}
  @moduledoc ~s"""
  Parameters used when creating a label for an order
  """

  @type t :: %Shipstation.Structs.Label{
    orderId: integer,
    carrierCode: String.t,
    serviceCode: String.t,
    packageCode: String.t,
    confirmation: String.t,
    shipDate: String.t,
    weight: Weight.t,
    dimensions: Dimension.t,
    insuranceOptions: InsuranceOption.t,
    advancedOptions: AdvancedOption.t,
    testLabel: boolean
  }

  defstruct orderId: nil,
            carrierCode: nil,
            serviceCode: nil,
            packageCode: nil,
            confirmation: nil,
            shipDate: nil,
            weight: %Weight{},
            dimensions: %Dimension{},
            insuranceOptions: %InsuranceOption{},
            internationalOptions: %InternationalOption{},
            advancedOptions: %AdvancedOption{},
            testLabel: false
end
