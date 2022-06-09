defmodule CurrencyConvertexApi.Repo do
  use Ecto.Repo,
    otp_app: :currency_convertex_api,
    adapter: Ecto.Adapters.Postgres
end
