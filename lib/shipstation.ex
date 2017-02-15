defmodule Shipstation do
  @moduledoc ~s"""
    Shipstation is a piece of software which makes it easy to import, manage and
    ship your orders. They aim to streamline shipping for online sellers, no
    matter where they sell their products online.

    This hex package is designed to allow you to integrate your ecommerce
    product with Shipstation's [publicly accessible
    API](http://www.shipstation.com/developer-api/).
  """
  use Application
  import Supervisor.Spec

  @spec start(any, any) :: any
  def start(_type, _args) do
    children = [
      worker(Shipstation.RequestLimit, [])
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

end
