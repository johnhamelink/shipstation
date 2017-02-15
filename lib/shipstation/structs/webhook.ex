defmodule Shipstation.Structs.Webhook do
  @moduledoc ~s"""
  Parameters used when describing a webhook
  """

  @type t :: %Shipstation.Structs.Webhook{
    target_url: String.t,
    event: String.t,
    store_id: integer,
    friendly_name: String.t
  }

  defstruct target_url: nil,
            event: nil,
            store_id: 0,
            friendly_name: nil
end
