defmodule Shipstation.User do
  @moduledoc ~s"""
  Manage users in your account
  """
  @doc ~s"""
  List all users
  """
  @spec list(show_inactive :: boolean) :: Shipstation.response_type
  def list(show_inactive) do
    uri = %{Shipstation.base_uri | path: "/users"}
    Shipstation.call_api(:get, uri, %{showInactive: show_inactive})
  end

end
