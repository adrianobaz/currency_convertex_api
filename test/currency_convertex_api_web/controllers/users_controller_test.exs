defmodule CurrencyConvertexApiWeb.UsersControllerTest do
  use CurrencyConvertexApiWeb.ConnCase, async: true

  import CurrencyConvertexApi.Factory

  alias CurrencyConvertexApiWeb.Auth.Guardian

  describe "POST api/v1/users | create/2" do
    test "when all params is valid", %{conn: conn} do
      params = params_for(:user)

      assert %{"id" => _id, "name" => "Pedro Miguel", "token" => _token} =
               conn
               |> post(Routes.users_path(conn, :create, params))
               |> json_response(:created)
    end

    test "when there are invalid param(s)", %{conn: conn} do
      params = params_for(:user, name: "Fo", password: "asd")

      assert %{
               "message" => %{
                 "name" => ["should be at least 3 character(s)"],
                 "password" => ["should be at least 6 character(s)"]
               }
             } =
               conn
               |> post(Routes.users_path(conn, :create, params))
               |> json_response(:bad_request)
    end
  end

  describe "GET api/v1/users/:id | show/2" do
    setup %{conn: conn} do
      user = insert(:user)

      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      %{conn: conn, user: user}
    end

    test "when there are valid user id", %{conn: conn, user: %{id: user_id} = _user} do
      assert %{"id" => id, "name" => "Pedro Miguel"} =
               conn
               |> get(Routes.users_path(conn, :show, user_id))
               |> json_response(:ok)

      assert id == user_id
    end

    test "when there are inexistent user id", %{conn: conn} do
      valid_uuid = Ecto.UUID.generate()

      assert %{"message" => "User not found!"} =
               conn
               |> get(Routes.users_path(conn, :show, valid_uuid))
               |> json_response(:not_found)
    end

    test "when the value of auth token is invalid", %{
      conn: conn,
      user: %{id: user_id} = _user
    } do
      assert %{"message" => "unauthenticated"} =
               conn
               |> put_req_header("authorization", "")
               |> get(Routes.users_path(conn, :show, user_id))
               |> json_response(:unauthorized)
    end
  end

  describe "POST api/v1/signin | sign_in/2" do
    setup do
      user = insert(:user)

      %{user: user}
    end

    test "when all params are valid", %{
      conn: conn,
      user: %{id: user_id, password: password} = _user
    } do
      params = %{"id" => user_id, "password" => password}

      assert %{"token" => _token} =
               conn
               |> post(Routes.users_path(conn, :sign_in, params))
               |> json_response(:ok)
    end

    test "when there are invalid params", %{conn: conn, user: %{id: user_id} = _user} do
      invalid_params = %{"id" => user_id, "password" => 546_546_234}

      assert %{"message" => "Please verify your credentials!"} =
               conn
               |> post(Routes.users_path(conn, :sign_in, invalid_params))
               |> json_response(:unauthorized)
    end

    test "when there are missing params", %{conn: conn} do
      params_with_missing_values = %{"id" => Ecto.UUID.generate()}

      assert %{"message" => "Invalid or missing params!"} =
               conn
               |> post(Routes.users_path(conn, :sign_in, params_with_missing_values))
               |> json_response(:bad_request)
    end
  end
end
