defmodule CurrencyConvertexApi.ExchangeRates.Client do
  @moduledoc false

  use Tesla

  alias CurrencyConvertexApi.Error
  alias Tesla.Env

  require Logger

  @doc """
  %{
      "base" => "EUR",
      "date" => "2022-06-16",
      "rates" => %{"BRL" => 5.281387, "JPY" => 140.42208, "USD" => 1.044889},
      "success" => true,
      "timestamp" => 1655350143
  }
  """

  @base_url "http://api.exchangeratesapi.io/v1/latest"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Query, access_key: System.get_env("ACCESS_KEY_EXCHANGE_RATES", "key_test")

  def get_exchange_rates(url \\ @base_url, symbols) do
    url
    |> get(query: [symbols: symbols])
    |> case do
      {:ok, %Env{status: 200, body: body}} ->
        {:ok, body}

      {:ok, %Env{status: status, body: body}} ->
        message =
          "Status: #{status}. An error occur when request! Reason:  #{Jason.encode!(body)}"

        Logger.warn(message)
        {:error, Error.build(status, body)}
    end
  end
end
