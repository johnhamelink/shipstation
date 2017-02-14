defmodule Shipstation.Customer do

    @doc ~s"""
    Get a customer by their ID
    """
    def get(id) do
      uri = %{Shipstation.base_uri | path: "/customers/#{id}"}
      Shipstation.call_api(:get, uri, %{})
    end

    @doc ~s"""
    List all matching customers
    """
    def list(filter = %Shipstation.Filters.Customer{}) do
      uri = %{Shipstation.base_uri | path: "/customers"}
      Shipstation.call_api(:get, uri, filter)
    end

end
