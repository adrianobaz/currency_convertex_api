defmodule CurrencyConvertexApi.ConversionTransaction.Generate do
  @moduledoc false

  alias CurrencyConvertexApi.ConversionTransaction.Create
  alias CurrencyConvertexApi.ExchangeRates.Client
  alias CurrencyConvertexApi.Schema.ConversionTransaction

  @spec call(%{
          :destiny_currencys => list(String.t()),
          :origin_value => Decimal.t(),
          :user_id => integer()
        }) ::
          {:error,
           :incompatible_calendars
           | :invalid_unix_time
           | %CurrencyConvertexApi.Error{result: any, status: any}}
          | {:ok, list()}
  def call(%{user_id: user_id, origin_value: origin_value, destiny_currencys: destiny_currencys}) do
    string_symbols = Enum.join(destiny_currencys, ",")

    with {:ok, %{"timestamp" => timestamp, "base" => base, "rates" => rates}} <-
           Client.get_exchange_rates(string_symbols),
         {:ok, date_time} <- convert_millis_to_date_time(timestamp) do
      result =
        rates
        |> Stream.map(fn {currency, exchange_rate} ->
          do_insert(
            user_id,
            base,
            origin_value,
            currency,
            exchange_rate,
            date_time
          )
        end)
        |> Enum.to_list()

      {:ok, result}
    end
  end

  @spec do_insert(integer(), String.t(), number, String.t(), number, any) ::
          {:error, %CurrencyConvertexApi.Error{result: any, status: any}} | map
  defp do_insert(user_id, base, origin_value, currency, exchange_rate, date_time) do
    exchange_rate_with_precision = format_value_with_precision(exchange_rate)
    origin_value_with_precision = Decimal.round(origin_value, 2)

    conversion_transaction_params = %{
      user_id: user_id,
      origin_currency: base,
      origin_value: origin_value_with_precision,
      destiny_currency: currency,
      conversion_rate: exchange_rate_with_precision,
      created_at: date_time
    }

    with {:ok, %ConversionTransaction{} = conversion_transaction} <-
           Create.call(conversion_transaction_params) do
      destiny_value =
        conversion_transaction.conversion_rate
        |> Decimal.mult(conversion_transaction.origin_value)
        |> Decimal.round(2)

      conversion_transaction_params
      |> Map.put_new(:id, conversion_transaction.id)
      |> Map.put_new(:destiny_value, destiny_value)
    end
  end

  @spec convert_millis_to_date_time(integer) ::
          {:error, :incompatible_calendars | :invalid_unix_time} | {:ok, binary}
  defp convert_millis_to_date_time(millis) do
    millis
    |> DateTime.from_unix()
    |> case do
      {:ok, date_time} -> {:ok, DateTime.to_iso8601(date_time)}
      {:error, _} = result -> result
    end
  end

  defp format_value_with_precision(value, precision \\ 2)

  defp format_value_with_precision(value, precision) when is_integer(value) do
    value
    |> Decimal.round(precision)
  end

  defp format_value_with_precision(value, precision) when is_float(value) do
    value
    |> Float.to_string()
    |> Decimal.new()
    |> Decimal.round(precision)
  end
end
