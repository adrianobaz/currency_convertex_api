defmodule CurrencyConvertexApi.RequestExchangeTest do
  use CurrencyConvertexApi.DataCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApiWeb.RequestExchange
  alias Ecto.Changeset

  describe "validate_params/1" do
    test "when all params are valid" do
      params = build(:request_exchange_params)

      assert {:ok, _changes} = RequestExchange.validate_params(params)
    end

    test "when there are some invalid params" do
      params = build(:request_exchange_params, origin_value: 0, origin_currency: "AA")

      assert {:error, %Changeset{} = changeset} = RequestExchange.validate_params(params)
      refute changeset.valid?
    end
  end

  describe "validate_format_destiny_currencys/1" do
    test "should return valid changes when destiny currencys are valid" do
      params = build(:request_exchange_params)

      assert :ok = RequestExchange.validate_format_destiny_currencys(params)
    end

    test "should return error with message when there are invalid values for destiny currencys" do
      params = build(:request_exchange_params, destiny_currencys: ["AA", "FGHI", "L"])

      assert {:error, %{destiny_currencys: _message}} =
               RequestExchange.validate_format_destiny_currencys(params)
    end
  end
end
