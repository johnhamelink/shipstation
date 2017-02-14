defmodule Shipstation.Customer.Filter do
  defstruct stateCode: nil,
            countryCode: nil,
            marketplaceId: nil,
            tagId: nil,
            sortBy: nil,
            sortDir: nil,
            page: 1,
            pageSize: 100
end
