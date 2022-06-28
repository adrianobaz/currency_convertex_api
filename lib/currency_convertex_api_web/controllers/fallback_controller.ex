defmodule CurrencyConvertexApiWeb.FallbackController do
  use CurrencyConvertexApiWeb, :controller

  alias CurrencyConvertexApi.Error
  alias CurrencyConvertexApiWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: changeset_or_message}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset_or_message)
    |> IO.inspect()
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset)
    |> IO.inspect()
  end

  def call(conn, {:error, %{destiny_currencys: error_message}}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ErrorView)
    |> render("error.json", destiny_currencys: error_message)
    |> IO.inspect()
  end

  def call(conn, {:error, %{user_id: error_message}}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", user_id: error_message)
    |> IO.inspect()
  end
end
