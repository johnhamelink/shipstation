defmodule Shipstation.Structs.ProductTag do
  @moduledoc ~s"""
  This struct is used for describing product tags
  """

  @type t :: %Shipstation.Structs.ProductTag{
    tagId: integer,
    name: String.t
  }

  defstruct tagId: 0,
            name: nil
end
