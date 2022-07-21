defmodule CurrencyConvertexApiWeb.ConversionTransactionsController do
  @moduledoc false

  use CurrencyConvertexApiWeb, :controller

  alias CurrencyConvertexApiWeb.{RequestExchange, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, changes} <- RequestExchange.validate_params(params),
         :ok <- RequestExchange.validate_format_destiny_currencys(changes),
         {:ok, result} <- CurrencyConvertexApi.generate_conversion_transactions(changes) do
      conn
      |> put_status(:created)
      |> render("create.json", result: result)
    end
  end

  def show(conn, %{"user_id" => user_id}) do
    with {:ok, result} <- CurrencyConvertexApi.get_transactions_by(user_id) do
      conn
      |> put_status(:ok)
      |> render("show.json", result: result)
    end
  end
end
