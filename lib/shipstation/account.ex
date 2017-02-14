defmodule Shipstation.Account do
  @moduledoc ~s"""
  Manage shipstation accounts
  """

    @doc ~s"""
      Creates a new ShipStation account and generates an apiKey and apiSecret to
      be used by the newly created account.

      Please note: This endpoint does not require API key and API Secret
      credentials. The Authorization header can be left off. Use of this
      specific endpoint requires approval. This is the only endpoint to require
      approval. All other endpoints listed in this document can be accessed by
      submitting proper authorization credentials in the header of the request.
      To request use of this specific endpoint, please submit a case to
      apisupport@shipstation.com
    """
    @spec register(params :: Shipstation.Structs.Account.t) :: Shipstation.response_type
    def register(params = %Shipstation.Structs.Account{}) do
      uri = %{Shipstation.base_uri | path: "/accounts/registeraccount"}
      Shipstation.call_api(:post, uri, params)
    end

    @doc ~s"""
    List all tags defined for this account
    """
    @spec list_tags() :: Shipstation.response_type
    def list_tags do
      uri = %{Shipstation.base_uri | path: "/accounts/listtags"}
      Shipstation.call_api(:get, uri, %{})
    end

end
