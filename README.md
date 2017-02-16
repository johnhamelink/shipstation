# Shipstation

[![Ebert](https://ebertapp.io/github/johnhamelink/shipstation.svg)](https://ebertapp.io/github/johnhamelink/shipstation)
[![Travis](https://img.shields.io/travis/johnhamelink/shipstation.svg)](https://travis-ci.org/johnhamelink/shipstation)
[![Hex.pm](https://img.shields.io/hexpm/v/shipstation.svg)](https://hex.pm/packages/shipstation)
[![HexDocs](https://img.shields.io/badge/hex-docs-blue.svg)](https://hexdocs.pm/shipstation)
[![Libraries.io for GitHub](https://img.shields.io/librariesio/github/johnhamelink/shipstation.svg)](https://libraries.io/github/johnhamelink/shipstation)

---

### This library is now ready to undergo testing in staging & production environments, but it is *not* production ready.

Shipstation is an unofficial API client library for the [Shipstation](https://shipstation.com) API. This library implements all the functionality that exists in Shipstation's API, and also provides helpful features like automatic backpressure handling.

### Features
 - [x] A complete API
 - [x] Every API endpoint has been unit tested
 - [x] Configurable API endpoints (for using Shipstation's Apiary endpoint in testing, for example).
 - [x] Automatically handles backpressure using a [backpressure Agent](https://github.com/johnhamelink/shipstation/blob/master/lib/request_limit.ex)

## Installation

The package can be installed as:

  1. Add `shipstation` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:shipstation, "~> 0.2.0"}]
    end
    ```

  2. Ensure `shipstation` is started before your application:

    ```elixir
    def application do
      [applications: [:shipstation]]
    end
    ```

#### Todo List:
 - [ ] Deserialize JSON output into Model structs
