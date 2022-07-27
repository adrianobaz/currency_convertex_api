defmodule CurrencyConvertexApi.Users.CreateTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApi.Users.Create
  alias CurrencyConvertexApi.{Error, User}

  describe "call/1" do
    test "when all params are valid" do
      params = params_for(:user)

      assert {:ok,
              %User{
                name: "Pedro Miguel",
                password: "123456"
              }} = Create.call(params)
    end

    test "when there are some invalid params" do
      params = params_for(:user, name: "Fo", password: 12)

      expected_result = %{name: ["should be at least 3 character(s)"], password: ["is invalid"]}

      assert {:error, %Error{status: :bad_request, result: changeset}} = Create.call(params)

      assert errors_on(changeset) == expected_result
    end
  end
end
