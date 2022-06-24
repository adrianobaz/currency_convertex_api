defmodule CurrencyConvertexApi.ExchangeRates.Client do
  @moduledoc false

  use Tesla

  alias CurrencyConvertexApi.Error
  alias Tesla.Env

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
  plug Tesla.Middleware.Query, [access_key: "b925c23ac599142ce5fdc632d57cba8c"]

  def get_exchange_rates(url \\ @base_url, symbols) do
    url
    |> get(query: [symbols: symbols])
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid format for symbols!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
