defmodule Shipstation.Structs.Address do
  @moduledoc ~s"""
  This struct is used for describing an address
  """

  @type t :: %Shipstation.Structs.Address{
    name:            String.t,
    company:         String.t,
    street1:         String.t,
    street2:         String.t,
    street3:         String.t,
    city:            String.t,
    state:           String.t,
    postalCode:      String.t,
    country:         String.t,
    phone:           String.t,
    residential:     boolean,
    addressVerified: String.t
  }

  defstruct name:            nil,
            company:         nil,
            street1:         nil,
            street2:         nil,
            street3:         nil,
            city:            nil,
            state:           nil,
            postalCode:      nil,
            country:         nil,
            phone:           nil,
            residential:     false,
            addressVerified: nil

end
