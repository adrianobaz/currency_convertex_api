defmodule CurrencyConvertexApi.ConversionTransactions.GetTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.Schema.ConversionTransaction
  alias CurrencyConvertexApi.ConversionTransaction.Get

  describe "all_by/1" do
    setup do
      result = insert_list(3, :conversion_transaction_params)

      %{result: result}
    end
  end
end
