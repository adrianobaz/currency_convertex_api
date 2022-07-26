defmodule CurrencyConvertexApi.ConversionTransactions.GetTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.ConversionTransaction.Get

  describe "all_by/1" do
    setup do
      user = insert(:user)

      %{id: user_id} = user

      conversion_transactions = insert_list(3, :conversion_transaction, user_id: user_id)

      %{conversion_transactions: conversion_transactions, user: user}
    end

    test "when user id exists", %{
      conversion_transactions: conversion_transactions,
      user: %{id: user_id} = _user
    } do
      assert {:ok, result} = Get.all_by(user_id)
      assert conversion_transactions == result
    end

    test "when user id is invalid, returns empty list" do
      user_id_invalid = Ecto.UUID.generate()

      assert {:ok, []} = Get.all_by(user_id_invalid)
    end
  end
end
