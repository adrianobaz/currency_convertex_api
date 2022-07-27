defmodule CurrencyConvertexApi.Factory do
  use ExMachina.Ecto, repo: CurrencyConvertexApi.Repo

  alias CurrencyConvertexApi.ConversionTransaction
  alias CurrencyConvertexApi.User

  def request_exchange_params_factory do
    %{
      user_id: Ecto.UUID.generate(),
      origin_currency: "EUR",
      origin_value: Decimal.new("48.674545"),
      destiny_currencys: ["USD", "BRL", "JPY"]
    }
  end

  def conversion_transaction_params_factory do
    %{
      origin_currency: "EUR",
      origin_value: Decimal.new("48.674545"),
      destiny_currency: sequence(:destiny_currency, ["BRL", "JPY", "USD"]),
      conversion_rate: Decimal.new("1.06"),
      created_at: "2022-06-24T02:09:06Z"
    }
  end

  def conversion_transaction_factory do
    %ConversionTransaction{
      user_id: Ecto.UUID.generate(),
      origin_currency: "EUR",
      origin_value: Decimal.new("48.67"),
      destiny_currency: sequence(:destiny_currency, ["BRL", "JPY", "USD"]),
      conversion_rate:
        sequence(:conversion_rate, [
          Decimal.new("5.52"),
          Decimal.new("141.96"),
          Decimal.new("1.05")
        ]),
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

  def user_factory do
    %User{
      name: "Pedro Miguel",
      password: "123456",
      password_hash:
        "$argon2id$v=19$m=65536,t=8,p=2$/H0USPUg4OUlX+gCur1JxA$jyBkqaBT8jzKdjMQs7PUBj4+ILDhnQTIMfdU18M7bHw"
    }
  end
end
