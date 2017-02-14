defmodule Shipstation.Structs.Customer do
  @moduledoc ~s"""
  Parameters used when filtering customers
  """

  @type t :: %Shipstation.Structs.Customer{
    stateCode: String.t,
    countryCode: String.t,
    marketplaceId: integer,
    tagId: integer,
    sortBy: String.t,
    sortDir: String.t,
    page: non_neg_integer,
    pageSize: non_neg_integer
  }

  defstruct stateCode: nil,
            countryCode: nil,
            marketplaceId: nil,
            tagId: nil,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100
end
