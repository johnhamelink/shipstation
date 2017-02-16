# Shipstation

[![Ebert](https://ebertapp.io/github/johnhamelink/shipstation.svg)](https://ebertapp.io/github/johnhamelink/shipstation)
[![Travis](https://img.shields.io/travis/johnhamelink/shipstation.svg)](https://travis-ci.org/johnhamelink/shipstation)
[![Hex.pm](https://img.shields.io/hexpm/v/shipstation.svg)](https://hex.pm/packages/shipstation)
[![HexDocs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/shipstation)
[![Libraries.io for GitHub](https://img.shields.io/librariesio/github/johnhamelink/shipstation.svg)](https://libraries.io/github/johnhamelink/shipstation)

---

## This library is now ready to undergo testing in staging & production environments, but it is **not** production ready.

An API client library for [Shipstation](https://shipstation.com).

### Todo (PRs welcome):

 - [x] Finish building out API
 - [x] Add authentication layer for use against the actual API
 - [x] Configure base URL to connect to (for test/staging/production environments)
 - [x] Handle backpressure with a [backpressure Agent](https://github.com/johnhamelink/shipstation/blob/master/lib/request_limit.ex)
 - [ ] Deserialize JSON output into Model structs

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `shipstation` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:shipstation, "~> 0.1.0"}]
    end
    ```

  2. Ensure `shipstation` is started before your application:

    ```elixir
    def application do
      [applications: [:shipstation]]
    end
    ```
