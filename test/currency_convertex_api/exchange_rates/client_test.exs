defmodule CurrencyConvertexApi.ExchangeRates.ClientTest do
  use ExUnit.Case, async: true

  import CurrencyConvertexApi.Factory

  import Tesla.Mock
  alias Tesla.Env


  setup do

    params_response = build(:exchange_rate)

    mock(fn
      %{
        method: :get,
        query: [symbols: ["BRL", "JPY", "USD"], access_key: "valid_key"],
        url: "http://api.exchangeratesapi.io/v1/latest"
      } -> %Env{status: 200, body: params_response}
    end)

    :ok
  end


end
