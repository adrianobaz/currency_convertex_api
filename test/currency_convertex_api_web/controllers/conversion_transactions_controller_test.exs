defmodule CurrencyConvertexApiWeb.ConversionTransactionsControllerTest do
  use CurrencyConvertexApiWeb.ConnCase, async: true

  use Mimic

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApiWeb.Auth.Guardian
  alias CurrencyConvertexApi.ExchangeRates.Client

  @origin_currency "EUR"

  describe "POST /api/v1/conversion_transactions | create/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      %{conn: conn, user: user}
    end

    test "when all params are valid", %{
      conn: conn,
      user: %{id: user_id} = _user
    } do
      params = build(:request_exchange_params, %{user_id: user_id, origin_value: 48.674545})

      expect(Client, :get_exchange_rates, fn symbols_string ->
        assert symbols_string == "USD,BRL,JPY"
        {:ok, build(:exchange_rate)}
      end)

      assert [
               %{
                 "conversion_rate" => "5.52",
                 "destiny_currency" => "BRL",
                 "destiny_value" => "268.66",
                 "origin_currency" => @origin_currency,
                 "origin_value" => "48.67",
                 "user_id" => ^user_id
               },
               %{
                 "conversion_rate" => "141.96",
                 "destiny_currency" => "JPY",
                 "destiny_value" => "6909.19",
                 "origin_currency" => @origin_currency,
                 "origin_value" => "48.67",
                 "user_id" => ^user_id
               },
               %{
                 "conversion_rate" => "1.05",
                 "destiny_currency" => "USD",
                 "destiny_value" => "51.10",
                 "origin_currency" => @origin_currency,
                 "origin_value" => "48.67",
                 "user_id" => ^user_id
               }
             ] =
               conn
               |> post(Routes.conversion_transactions_path(conn, :create, params))
               |> json_response(:created)
    end

    test "when there are inexistent user id", %{conn: conn} do
      params =
        build(:request_exchange_params, %{user_id: Ecto.UUID.generate(), origin_value: 48.674545})

      assert %{"message" => "User not found!"} =
               conn
               |> post(Routes.conversion_transactions_path(conn, :create, params))
               |> json_response(:not_found)
    end

    test "when there are invalid user id", %{conn: conn} do
      params = build(:request_exchange_params, %{user_id: "some_id", origin_value: 48.674545})

      assert %{"message" => "Invalid UUID"} =
               conn
               |> post(Routes.conversion_transactions_path(conn, :create, params))
               |> json_response(:bad_request)
    end

    test "when there are invalid origin value and currency", %{
      conn: conn,
      user: %{id: user_id} = _user
    } do
      params =
        build(:request_exchange_params,
          user_id: user_id,
          origin_value: 0,
          origin_currency: "aa"
        )

      assert %{
               "message" => %{
                 "origin_value" => ["must be greater than 0"],
                 "origin_currency" => ["should be 3 character(s)"]
               }
             } =
               conn
               |> post(Routes.conversion_transactions_path(conn, :create, params))
               |> json_response(:unprocessable_entity)
    end

    test "when there are invalid destiny currencys", %{conn: conn, user: %{id: user_id} = _user} do
      params =
        build(:request_exchange_params,
          user_id: user_id,
          origin_value: 48.674545,
          destiny_currencys: ["AA", 123, "invalid_symbol"]
        )

      assert %{
               "destiny_currencys" => [
                 [0, "length must be greater than or equal to 3"],
                 [1, "does not match format"],
                 [2, "length must be less than or equal to 3"]
               ]
             } =
               conn
               |> post(Routes.conversion_transactions_path(conn, :create, params))
               |> json_response(:unprocessable_entity)
    end
  end

  describe " show/2" do
    test "" do
    end
  end
end
