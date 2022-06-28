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

  @derive Jason.Encoder

  @base_url "http://api.exchangeratesapi.io/v1/latest"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Query, [access_key: System.get_env("ACCESS_KEY_EXCHANGE_RATES")]

  def get_exchange_rates(url \\ @base_url, symbols) do
    url
    |> get(query: [symbols: symbols])
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: status, body: body}}) do
    string_result = Jason.encode!(body)
    message = "Status: #{status}. An error occur when request! Reason: " <> string_result
    Logger.warn(message)
    {:error, Error.build(status, message)}
  end
end
