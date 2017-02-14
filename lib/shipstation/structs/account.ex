defmodule Shipstation.Structs.Account do
  @moduledoc ~s"""
  Struct for input parameters when registering a new account
  """

  @type t :: %Shipstation.Structs.Account{
    firstName: String.t,
    lastName: String.t,
    email: String.t,
    password: String.t,
    companyName: String.t,
    addr1: String.t,
    addr2: String.t,
    city: String.t,
    state: String.t,
    zip: String.t,
    countryCode: String.t,
    phone: String.t
  }

  defstruct firstName: nil,
            lastName: nil,
            email: nil,
            password: nil,
            shippingOriginCountryCode: "US",
            companyName: nil,
            addr1: nil,
            addr2: nil,
            city: nil,
            state: nil,
            zip: nil,
            countryCode: nil,
            phone: nil
end
