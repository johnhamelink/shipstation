defmodule Shipstation.Structs.ProductCategory do
  @moduledoc ~s"""
  This struct is used for describing product categories
  """

  @type t :: %Shipstation.Structs.ProductCategory{
    categoryId: integer,
    name: String.t
  }

  defstruct categoryId: 0,
            name: nil
end
