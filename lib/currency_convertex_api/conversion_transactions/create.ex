defmodule CurrencyConvertexApi.ConversionTransaction.Create do
  alias CurrencyConvertexApi.{ConversionTransaction, Repo, Error}

  @moduledoc false
  def call(%{} = params) do
    params
    |> ConversionTransaction.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  def call(_anything), do: "Enter the data in a map format"

  defp handle_insert({:ok, %ConversionTransaction{}} = result), do: result

  defp handle_insert({:error, changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
