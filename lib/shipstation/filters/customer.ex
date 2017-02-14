defmodule Shipstation.Filters.Customer do
  @moduledoc ~s"""
  Parameters used when filtering customers
  """

  defstruct stateCode: nil,
            countryCode: nil,
            marketplaceId: nil,
            tagId: nil,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100
end
