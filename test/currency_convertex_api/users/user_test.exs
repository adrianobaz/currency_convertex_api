defmodule CurrencyConvertexApi.UserTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias Ecto.Changeset
  alias CurrencyConvertexApi.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      assert %Changeset{valid?: true, changes: %{name: "Pedro Miguel", password: "123456"}} =
               User.changeset(params)
    end

    test "when there are some invalid params, returns an invalid changeset" do
      params = build(:user_params, %{password: "123", name: "Fo"})

      expected_response = %{
        name: ["should be at least 3 character(s)"],
        password: ["should be at least 6 character(s)"]
      }

      response = User.changeset(params)

      assert %Changeset{valid?: false} = response
      assert errors_on(response) == expected_response
    end
  end
end
