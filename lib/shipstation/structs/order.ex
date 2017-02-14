defmodule Shipstation.Structs.Order do
  defstruct orderId: nil,
            carrierCode: nil,
            serviceCode: nil,
            packageCode: nil,
            confirmation: nil,
            shipDate: nil,
            weight: %Shipstation.Structs.Weight{},
            dimensions: nil,           # TODO: Set this to a default dimensions struct
            insuranceOptions: nil,     # TODO: Set this to a default insuranceOptions struct
            internationalOptions: nil, # TODO: Set this to a default internationalOptions struct
            advancedOptions: nil,      # TODO: Set this to a default advancedOptions struct
            testLabel: false
end
