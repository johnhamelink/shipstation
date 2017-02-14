defmodule Shipstation.Structs.AdvancedOption do
  @moduledoc ~s"""
  Parameters used when specifying any other advanced options required for an
  order
  """

  @type t :: %Shipstation.Structs.AdvancedOption{
    warehouseId: integer,
    nonMachinable: boolean,
    saturdayDelivery: boolean,
    containsAlcohol: boolean,
    storeId: integer,
    customField1: String.t,
    customField2: String.t,
    customField3: String.t,
    source: String.t,
    mergedOrSplit: boolean,
    mergedIds: [integer],
    parentId: integer,
    billToParty: String.t,
    billToAccount: String.t,
    billToPostalCode: String.t,
    billToCountryCode: String.t
  }

  defstruct warehouseId: nil,
            nonMachinable: false,
            saturdayDelivery: false,
            containsAlcohol: false,
            storeId: nil,
            customField1: nil,
            customField2: nil,
            customField3: nil,
            source: nil,
            mergedOrSplit: nil,
            mergedIds: [],
            parentId: nil,
            billToParty: nil,
            billToAccount: nil,
            billToPostalCode: nil,
            billToCountryCode: nil
end
