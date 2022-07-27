defmodule CurrencyConvertexApi.ConversionTransactionTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias Ecto.Changeset
  alias CurrencyConvertexApi.ConversionTransaction

  describe "changeset/2" do
    setup do
      %{id: user_id} = insert(:user)

      params = build(:conversion_transaction_params, user_id: user_id)

      invalid_params =
        build(:conversion_transaction_params, %{destiny_currency: "ABCD", origin_value: 0})

      %{params: params, invalid_params: invalid_params}
    end

    test "when all params are valid", %{
      params: %{user_id: user_id} = params
    } do
      assert %Changeset{
               changes: %{
                 user_id: ^user_id
               },
               valid?: true
             } = ConversionTransaction.changeset(params)
    end

    test "when there are some error, returns an invalid changeset", %{
      invalid_params: invalid_params
    } do
      changeset = ConversionTransaction.changeset(invalid_params)

      expected_response = %{
        user_id: ["can't be blank"],
        destiny_currency: ["should be 3 character(s)"],
        origin_value: ["must be greater than 0"]
      }

      refute changeset.valid?
      assert errors_on(changeset) == expected_response
    end

    Enum.each([:user_id, :origin_currency, :destiny_currency, :conversion_rate], fn field ->
      test "when there are some error, returns an invalid changeset if #{field} was missing",
           %{params: params} do
        assert %Changeset{valid?: false} =
                 params
                 |> Map.drop([unquote(field)])
                 |> ConversionTransaction.changeset()
      end
    end)
  end
end
