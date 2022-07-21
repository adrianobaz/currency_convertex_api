defmodule CurrencyConvertexApi do
  @moduledoc """
  CurrencyConvertexApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias CurrencyConvertexApi.ConversionTransaction.Generate, as: ConversionTransactionGenerate
  alias CurrencyConvertexApi.ConversionTransaction.Get, as: ConversionTransactionGet
  alias CurrencyConvertexApi.Users.Create, as: UserCreate
  alias CurrencyConvertexApi.Users.Get, as: UserGet

  defdelegate generate_conversion_transactions(params),
    to: ConversionTransactionGenerate,
    as: :call

  defdelegate get_transactions_by(user_id), to: ConversionTransactionGet, as: :all_by
  defdelegate get_user_by_id(id), to: UserGet, as: :by_id

  defdelegate create_user(params), to: UserCreate, as: :call
end
