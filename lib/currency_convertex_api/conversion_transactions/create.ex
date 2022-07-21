defmodule CurrencyConvertexApi.ConversionTransaction.Create do
  alias CurrencyConvertexApi.{Repo, Error}
  alias CurrencyConvertexApi.Schema.ConversionTransaction

  @moduledoc false

  def call(%{} = params) do
    params
    |> ConversionTransaction.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %ConversionTransaction{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
