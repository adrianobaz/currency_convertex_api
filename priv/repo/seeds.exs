# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CurrencyConvertexApi.Repo.insert!(%CurrencyConvertexApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias CurrencyConvertexApi.ConversionTransaction

# CurrencyConvertexApi.Repo.insert_all(ConversionTransaction, [
#   %{
#     conversion_rate: #Decimal<5.52>,
#     created_at: "2022-06-24T02:09:06Z",
#     destiny_currency: "BRL",
#     origin_currency: "EUR",
#     origin_value: #Decimal<48.67>,
#     user_id: "f0e7f189-8bc6-41d9-925b-d8503c91d334"
#   },
#   %{
#     conversion_rate: #Decimal<141.96>,
#     created_at: "2022-06-24T02:09:06Z",
#     destiny_currency: "JPY",
#     origin_currency: "EUR",
#     origin_value: #Decimal<48.67>,
#     user_id: "f0e7f189-8bc6-41d9-925b-d8503c91d334"
#   },
#   %{
#     conversion_rate: #Decimal<1.05>,
#     created_at: "2022-06-24T02:09:06Z",
#     origin_currency: "EUR",
#     origin_value: #Decimal<48.67>,
#     user_id: "f0e7f189-8bc6-41d9-925b-d8503c91d334"
#   }
# ], returning: true)
