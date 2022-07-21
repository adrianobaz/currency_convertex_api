defmodule CurrencyConvertexApi.ConversionTransactions.GetTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.ConversionTransaction.Get

  describe "all_by/1" do
    setup do
      result = insert_list(3, :conversion_transaction)

      %{result: result}
    end

    test "when user id exists, returns conversion transactios successfully", %{
      result: result
    } do
      [%{user_id: user_id} | _t] = result

      assert {:ok, ^result} = Get.all_by(user_id)
    end

    test "when user id is invalid, returns empty list", %{result: result} do
      [%{user_id: user_id} | _t] = result

      user_id_invalid = user_id + 1

      assert {:ok, []} = Get.all_by(user_id_invalid)
    end
  end
end
