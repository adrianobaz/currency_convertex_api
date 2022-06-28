defmodule CurrencyConvertexApi.Schema.ConversionTransactionTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias Ecto.Changeset
  alias CurrencyConvertexApi.Schema.ConversionTransaction

  describe "changeset/2" do

    setup do
      params = build(:conversion_transaction_params)

      %{params: params}
    end

    test "when all params are valid, returns a valid changeset", %{params: params} do
      response = ConversionTransaction.changeset(params)

      assert %Changeset{changes: %{user_id: 2, origin_currency: "EUR", destiny_currency: "USD"}, valid?: true} = response
    end

    for field <- [:user_id, :origin_currency, :destiny_currency, :conversion_rate] do
      test "returns an invalid changeset if #{field} was missing", %{params: params} do
        assert %Changeset{valid?: false} =
                 params
                 |> Map.drop([unquote(field)])
                 |> ConversionTransaction.changeset()
      end
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:conversion_transaction_params, %{user_id: 0, origin_value: 0})

      response = ConversionTransaction.changeset(params)

      expected_response = %{
        user_id: ["must be greater than 0"],
        origin_value: ["must be greater than 0"]
      }

      assert errors_on(response) == expected_response
    end

  end

end
