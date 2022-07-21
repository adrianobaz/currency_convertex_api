defmodule CurrencyConvertexApi.Users.GetTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.Users.Get
  alias CurrencyConvertexApi.{Error, User}

  describe "by_id/1" do
    test "when user exists, must return user by id" do
      %{id: user_id} = insert(:user)

      assert {:ok, %User{id: ^user_id}} = Get.by_id(user_id)
    end

    test "when user not exists, must return error with reason" do
      invalid_id = Ecto.UUID.generate()

      assert {:error, %Error{status: :not_found, result: "User not found!"}} =
               Get.by_id(invalid_id)
    end
  end
end
