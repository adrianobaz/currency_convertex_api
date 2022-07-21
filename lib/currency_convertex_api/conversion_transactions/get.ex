defmodule CurrencyConvertexApi.ConversionTransaction.Get do
  @moduledoc false

  alias CurrencyConvertexApi.Repo
  alias CurrencyConvertexApi.ConversionTransaction

  import Ecto.Query

  @spec all_by(binary()) :: {:ok, list()}
  def all_by(user_id) when is_binary(user_id) do
    result =
      ConversionTransaction
      |> where(user_id: ^user_id)
      |> Repo.all()

    {:ok, result}
  end
end
