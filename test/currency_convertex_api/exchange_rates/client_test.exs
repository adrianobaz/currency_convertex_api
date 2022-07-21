defmodule CurrencyConvertexApi.ExchangeRates.ClientTest do
  use ExUnit.Case, async: true

  import CurrencyConvertexApi.Factory
  import Tesla.Mock

  alias Tesla.Env
  alias CurrencyConvertexApi.ExchangeRates.Client
  alias CurrencyConvertexApi.Error

  describe "get_exchange_rates/2" do
    setup do
      response_success = build(:exchange_rate)

      response_fail = %{
        "error" => %{
          "code" => "invalid_currency_codes",
          "message" =>
            "You have provided one or more invalid Currency Codes. [Required format: currencies=EUR,USD,GBP,...]"
        }
      }

      mock(fn
        %{
          method: :get,
          query: [symbols: "BRL,JPY,USD", access_key: "key_test"],
          url: "http://api.exchangeratesapi.io/v1/latest"
        } ->
          %Env{status: 200, body: response_success}

        %{
          method: :get,
          query: [symbols: "PPP,AAA", access_key: "key_test"],
          url: "http://api.exchangeratesapi.io/v1/latest"
        } ->
          %Env{status: 400, body: response_fail}
      end)

      %{response_success: response_success, response_fail: response_fail}
    end

    test "when all requeriments for the request to be executed successfully", %{
      response_success: response_success
    } do
      symbols = "BRL,JPY,USD"
      assert {:ok, body} = Client.get_exchange_rates(symbols)
      assert body == response_success
    end

    test "when there are some error to execute a request", %{response_fail: response_fail} do
      symbols = "PPP,AAA"
      assert {:error, %Error{status: 400, result: result}} = Client.get_exchange_rates(symbols)
      assert result == response_fail
    end
  end
end
