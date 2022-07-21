{:ok, _} = Application.ensure_all_started(:ex_machina)
{:ok, _} = Application.ensure_all_started(:mimic)
Mimic.copy(CurrencyConvertexApi.ExchangeRates.Client)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(CurrencyConvertexApi.Repo, :manual)
