defmodule CurrencyConvertexApi.ConversionTransactions.GenerateTransactionsTest do
  use CurrencyConvertexApi.DataCase, async: true
  use Mimic

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.ConversionTransaction.Generate
  alias CurrencyConvertexApi.ExchangeRates.Client
  alias CurrencyConvertexApi.Error

  @origin_value Decimal.new("48.67")
  @origin_currency "EUR"

  describe "call/1" do
    setup do
      %{id: user_id} = insert(:user)

      %{user_id: user_id}
    end

    test "when there are valid params, return with success conversion transactions list", %{
      user_id: user_id
    } do
      params = build(:request_exchange_params, user_id: user_id)

      expect(Client, :get_exchange_rates, fn symbols_string ->
        assert symbols_string == "USD,BRL,JPY"
        {:ok, build(:exchange_rate)}
      end)

      assert {:ok, [head | tail]} = Generate.call(params)

      assert [
               %{
                 destiny_currency: "BRL",
                 origin_currency: @origin_currency,
                 origin_value: @origin_value,
                 user_id: ^user_id
               },
               %{
                 destiny_currency: "JPY",
                 origin_currency: @origin_currency,
                 origin_value: @origin_value,
                 user_id: ^user_id
               },
               %{
                 destiny_currency: "USD",
                 origin_currency: @origin_currency,
                 origin_value: @origin_value,
                 user_id: ^user_id
               }
             ] = [head] ++ tail
    end

    test "when there is passed user id that NOT exists, return not found" do
      params = build(:request_exchange_params)

      assert {:error, %Error{status: :not_found, result: result}} = Generate.call(params)
      assert result == "User not found!"
    end

    test "when there are invalid arguments, return error with bad request", %{user_id: user_id} do
      params =
        build(:request_exchange_params, %{
          user_id: user_id,
          destiny_currencys: ["USD", "bBb", "JJJ"]
        })

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

      assert {:error, %Error{status: 400, result: response}} = Generate.call(params)
      assert result == response
    end

    test "when timestamp argument is invalid, return an error", %{user_id: user_id} do
      params = build(:request_exchange_params, user_id: user_id)

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
