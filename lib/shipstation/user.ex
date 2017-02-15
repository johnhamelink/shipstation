defmodule Shipstation.User do
  @moduledoc ~s"""
  Manage users in your account
  """
  @doc ~s"""
  List all users
  """
  @spec list(show_inactive :: boolean) :: Shipstation.Client.response_type
  def list(show_inactive) do
    uri = %{Shipstation.Client.base_uri | path: "/users"}
    Shipstation.Client.call_api(:get, uri, %{showInactive: show_inactive})
  end

end
