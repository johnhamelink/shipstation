defmodule Shipstation.Structs.ProductFilter do
  @moduledoc ~s"""
  This struct is used for filtering products
  """

  @type t :: %Shipstation.Structs.ProductFilter{
    sku:               String.t,
    name:              String.t,
    productCategoryId: integer,
    productTypeId:     integer,
    tagId:             integer,
    showInactive:      boolean,
    sortBy:            String.t,
    sortDir:           String.t,
    page:              non_neg_integer,
    pageSize:          non_neg_integer
  }

  defstruct sku:               nil,
            name:              nil,
            productCategoryId: 0,
            productTypeId:     0,
            tagId:             0,
            startDate:         nil,
            endDate:           nil,
            showInactive:      false,
            sortBy:            nil,
            sortDir:           nil,
            page:              1,
            pageSize:          100
end
