defmodule CurrencyConvertexApi.ConversionTransaction.Create do
  alias CurrencyConvertexApi.{Repo, Error}
  alias CurrencyConvertexApi.ConversionTransaction

  @moduledoc false

  def call(%{} = params) do
    params
    |> ConversionTransaction.changeset()
    |> Repo.insert()
    |> case do
      {:ok, %ConversionTransaction{}} = result -> result
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
