defmodule CurrencyConvertexApiWeb.ConversionTransactionsController do
  @moduledoc false

  use CurrencyConvertexApiWeb, :controller

  alias CurrencyConvertexApi
  alias CurrencyConvertexApiWeb.{RequestExchange, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, changes} <- RequestExchange.validate_params(params),
         :ok <- RequestExchange.validate_format_destiny_currencys(changes),
         list_result <- CurrencyConvertexApi.generate_conversion_transactions(changes) do
        conn
        |> IO.inspect()
        |> put_status(:created)
        |> render("create.json", result: list_result)
        |> IO.inspect()
      end
  end

end
