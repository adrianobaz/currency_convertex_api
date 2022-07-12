defmodule CurrencyConvertexApi.Factory do
  use ExMachina.Ecto, repo: CurrencyConvertexApi.Repo

  alias CurrencyConvertexApi.Schema.ConversionTransaction

  def request_exchange_params_factory do
    %{
      user_id: 2,
      origin_value: Decimal.new("48.674545"),
      destiny_currencys: ["USD", "BRL", "JPY"]
    }
  end

  def conversion_transaction_params_factory do
    %{
      user_id: 2,
      origin_currency: "EUR",
      origin_value: Decimal.new("38.89"),
      destiny_currency: "USD",
      conversion_rate: Decimal.new("1.06"),
      created_at: "2022-06-24T02:09:06Z"
    }
  end

  def conversion_transaction_factory do
    %ConversionTransaction{
      user_id: 2,
      origin_currency: "EUR",
      origin_value: Decimal.new("38.89"),
      destiny_currency: "USD",
      conversion_rate: Decimal.new("1.06"),
      created_at: ~U[2022-06-16 03:29:03Z]
    }
  end

  def exchange_rate_factory do
    %{
      "success" => true,
      "timestamp" => 1_656_036_546,
      "base" => "EUR",
      "date" => "2022-06-24",
      "rates" => %{
        "BRL" => 5.517014,
        "JPY" => 141.955699,
        "USD" => 1.052986
      }
    }
  end
end
