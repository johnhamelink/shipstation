defmodule Shipstation.Structs.Store do
  @moduledoc ~s"""
  Parameters used when filtering stores
  """

  @type t :: %Shipstation.Structs.Store{
    showInactive: boolean,
    marketplaceId: integer
  }

  defstruct showInactive: false,
            marketplaceId: 0
end
