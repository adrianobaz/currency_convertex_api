defmodule CurrencyConvertexApi.ConversionTransactions.GenerateTransactionsTest do
  use CurrencyConvertexApi.DataCase, async: true
  use Mimic

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.ConversionTransaction.Generate
  alias CurrencyConvertexApi.ExchangeRates.Client
  alias CurrencyConvertexApi.Error

  describe "call/1" do
    test "when there are valid params, return with success conversion transactions list" do
      params = build(:request_exchange_params)

      expect(Client, :get_exchange_rates, fn symbols_string ->
        assert symbols_string == "USD,BRL,JPY"
        {:ok, build(:exchange_rate)}
      end)

      assert {:ok, [h | t]} = Generate.call(params)

      list_indexed = Enum.with_index([h] ++ t)

      list_indexed
      |> Enum.each(fn {conversion_transaction, index} ->
        {value, _} = List.keyfind(list_indexed, index, 1)
        assert value == conversion_transaction
      end)
    end

    test "when there are invalid arguments, return error with bad request" do
      params = build(:request_exchange_params, destiny_currencys: ["USD", "bBb", "JJJ"])

      result = %{
        "error" => %{
          "code" => "invalid_currency_codes",
          "message" =>
            "You have provided one or more invalid Currency Codes. [Required format: currencies=EUR,USD,GBP,...]"
        }
      }

      expect(Client, :get_exchange_rates, fn symbols_string ->
        assert symbols_string == "USD,bBb,JJJ"
        {:error, %Error{status: 400, result: result}}
      end)

      assert {:error, %Error{status: status, result: response}} = Generate.call(params)
      assert result == response
      assert status == 400
    end

    test "when timestamp argument is invalid, return an error" do
      params = build(:request_exchange_params)

      expect(Client, :get_exchange_rates, fn symbols_string ->
        assert symbols_string == "USD,BRL,JPY"

        {:ok,
         %{
           "success" => true,
           "timestamp" => 253_402_300_800,
           "base" => "EUR",
           "date" => "2022-06-24",
           "rates" => %{
             "BRL" => 5.517014,
             "JPY" => 141.955699,
             "USD" => 1.052986
           }
         }}
      end)

      assert {:error, :invalid_unix_time} = Generate.call(params)
    end
  end
end
