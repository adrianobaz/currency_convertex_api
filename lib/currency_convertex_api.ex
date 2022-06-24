defmodule CurrencyConvertexApi do
  @moduledoc """
  CurrencyConvertexApi keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias CurrencyConvertexApi.ConversionTransaction.Generate, as: ConversionTransactionGenerate

  defdelegate generate_conversion_transactions(params), to: ConversionTransactionGenerate, as: :call

end
