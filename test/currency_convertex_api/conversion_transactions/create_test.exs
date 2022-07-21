defmodule CurrencyConvertexApi.ConversionTransactions.CreateTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.ConversionTransaction
  alias CurrencyConvertexApi.Error
  alias CurrencyConvertexApi.ConversionTransaction.Create

  describe "call/2" do
    setup do
      %{id: user_id} = insert(:user)

      valid_params = build(:conversion_transaction_params, %{user_id: user_id})

      invalid_params =
        build(:conversion_transaction_params, %{
          user_id: user_id,
          origin_value: 0,
          conversion_rate: 0
        })

      %{valid_params: valid_params, invalid_params: invalid_params}
    end

    test "when all params are valid", %{valid_params: valid_params} do
      assert {:ok, %ConversionTransaction{id: id, origin_currency: "EUR"}} =
               Create.call(valid_params)

      assert %ConversionTransaction{} = CurrencyConvertexApi.Repo.get(ConversionTransaction, id)
    end

    test "when there are some invalid params", %{invalid_params: invalid_params} do
      expected_response = %{
        origin_value: ["must be greater than 0"],
        conversion_rate: ["must be greater than 0"]
      }

      assert {:error, %Error{result: changeset, status: :bad_request}} =
               Create.call(invalid_params)

      refute changeset.valid?
      assert errors_on(changeset) == expected_response
    end
  end
end
