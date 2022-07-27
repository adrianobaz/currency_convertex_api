defmodule CurrencyConvertexApiWeb.Plugs.UuidCheckerTest do
  use CurrencyConvertexApiWeb.ConnCase, async: true

  alias CurrencyConvertexApiWeb.Plugs.UuidChecker
  alias Plug.Conn

  describe "call/2" do
    test "when has valid id", %{conn: conn} do
      valid_uuid = Ecto.UUID.generate()
      conn_with_params = struct(conn, params: %{"id" => valid_uuid})
      assert %Conn{params: %{"id" => id}} = UuidChecker.call(conn_with_params, "")
      assert valid_uuid == id
    end

    test "when has valid user id", %{conn: conn} do
      valid_uuid = Ecto.UUID.generate()
      conn_with_params = struct(conn, params: %{"user_id" => valid_uuid})
      assert %Conn{params: %{"user_id" => user_id}} = UuidChecker.call(conn_with_params, "")
      assert valid_uuid == user_id
    end

    test "when has invalid id", %{conn: conn} do
      conn_with_invalid_params = struct(conn, params: %{"user_id" => "invalid_uuid"})

      expected_resp = ~s({"message":"Invalid UUID"})
      assert %Conn{resp_body: resp} = UuidChecker.call(conn_with_invalid_params, "")
      assert expected_resp == resp
    end
  end
end
