defmodule CurrencyConvertexApi.ConversionTransaction.Generate do
  @moduledoc false

  alias CurrencyConvertexApi.ConversionTransaction.Create, as: ConversionTransactionCreate
  alias CurrencyConvertexApi.ExchangeRates.Client
  alias CurrencyConvertexApi.ConversionTransaction

  defdelegate create_conversion_transaction(params), to: ConversionTransactionCreate, as: :call

  @spec call(%{
          :destiny_currencys => list(String.t()),
          :origin_value => Decimal.t(),
          :user_id => integer,
          optional(any) => any
        }) ::
          list
          | {:error,
             :incompatible_calendars
             | :invalid_unix_time
             | %CurrencyConvertexApi.Error{result: any, status: any}}
          | {:ok, any}
  def call(%{user_id: user_id, origin_value: origin_value, destiny_currencys: destiny_currencys}) do
    string_symbols = Enum.join(destiny_currencys, ",")
    with {:ok, %{"timestamp" => timestamp, "base" => base, "rates" => rates}} <- Client.get_exchange_rates(string_symbols),
         {:ok, date_time} <- convert_millis_to_date_time(timestamp) do

          rates
          |> Stream.map(fn {currency, exchange_rate} -> do_insert(
            user_id,
            base,
            origin_value,
            currency,
            exchange_rate,
            date_time)
          end)
          |> Enum.to_list()
    end
  end

  @spec do_insert(integer, String.t(), float, String.t(), float, DateTime.t()) ::
          <<_::240>> | {:error, %CurrencyConvertexApi.Error{result: any, status: any}} | map
  defp do_insert(user_id, base, origin_value, currency, exchange_rate, date_time) do
    params = %{
      user_id: user_id,
      origin_currency: base,
      origin_value: origin_value,
      destiny_currency: currency,
      conversion_rate: exchange_rate,
      created_at: date_time
    }

    with {:ok, %ConversionTransaction{} = conversion_transaction} <- create_conversion_transaction(params) do
      params
      |> Map.put_new(:id, conversion_transaction.id)
      |> Map.put_new(:destiny_value, calculate_destiny_value(conversion_transaction.conversion_rate, conversion_transaction.conversion_rate))
      |> IO.inspect()
    end
  end

  defp calculate_destiny_value(origin_value, exchange_rate), do: Decimal.mult(origin_value, exchange_rate)

  @spec convert_millis_to_date_time(integer) ::
          {:error, :incompatible_calendars | :invalid_unix_time} | {:ok, DateTime.t()}
  defp convert_millis_to_date_time(millis), do: DateTime.from_unix(millis)
end
