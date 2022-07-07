defmodule CurrencyConvertexApiWeb.ConversionTransactionsController do
  @moduledoc false

  use CurrencyConvertexApiWeb, :controller

  alias CurrencyConvertexApi
  alias CurrencyConvertexApiWeb.{RequestExchange, FallbackController}

  action_fallback FallbackController

  @validator_id %{
    user_id: [type: :string, into: &String.to_integer/1, format: ~r/^[[:digit:]]+$/]
  }

  def create(conn, params) do
    with {:ok, changes} <- RequestExchange.validate_params(params),
         :ok <- RequestExchange.validate_format_destiny_currencys(changes),
         {:ok, result} <- CurrencyConvertexApi.generate_conversion_transactions(changes) do
      conn
      |> put_status(:created)
      |> render("create.json", result: result)
      |> IO.inspect()
    end
  end

  def show(conn, %{"user_id" => _} = param) do
    with {:ok, %{user_id: valid_user_id}} <- Tarams.cast(param, @validator_id),
         {:ok, result} <- CurrencyConvertexApi.get_transactions_by(valid_user_id) do
      conn
      |> put_status(:ok)
      |> render("show.json", result: result)
      |> IO.inspect()
    end
  end
end
