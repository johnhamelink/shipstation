# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :shipstation,
  base_uri: "https://ssapi.shipstation.com",
  auth: %{
    api_key: nil,
    api_secret: nil
  }

import_config "#{Mix.env}.exs"
