use Mix.Config

config :shipstation,
  base_uri: "https://private-anon-ab6eb750a3-shipstation.apiary-mock.com",
  headers: %{
    limit: "X-Apiary-Ratelimit-Limit",
    remaining: "X-Apiary-Ratelimit-Remaining",
    reset: "X-Apiary-Ratelimit-Reset"
  },
  auth: %{
    api_key: nil,
    api_secret: nil
  }
