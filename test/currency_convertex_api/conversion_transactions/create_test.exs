defmodule CurrencyConvertexApi.ConversionTransactions.CreateTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.Schema.ConversionTransaction
  alias CurrencyConvertexApi.Error
  alias CurrencyConvertexApi.ConversionTransaction.Create

  describe "call/2" do
    setup do
      valid_params = build(:conversion_transaction_params)

      invalid_params =
        build(:conversion_transaction_params, %{origin_value: 0, user_id: 0, conversion_rate: 0})

      [valid_params: valid_params, invalid_params: invalid_params]
    end

    test "when all params are valid", context do
      assert {:ok, %ConversionTransaction{id: id, user_id: 2}} =
               Create.call(context[:valid_params])

      assert %ConversionTransaction{} = CurrencyConvertexApi.Repo.get(ConversionTransaction, id)
    end

    test "when there are some invalid params", context do
      expected_response = %{
        origin_value: ["must be greater than 0"],
        user_id: ["must be greater than 0"],
        conversion_rate: ["must be greater than 0"]
      }

      assert {:error, %Error{result: changeset, status: :bad_request}} =
               Create.call(context[:invalid_params])

      assert errors_on(changeset) == expected_response
    end
  end
end
