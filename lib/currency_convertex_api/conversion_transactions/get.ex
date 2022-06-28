defmodule CurrencyConvertexApi.ConversionTransaction.Get do
  @moduledoc false

  alias CurrencyConvertexApi.Repo
  alias CurrencyConvertexApi.Schema.ConversionTransaction

  import Ecto.Query

  @spec all_by(integer()) :: {:ok, list()}
  def all_by(user_id) do
    result =
      from(ct in ConversionTransaction, where: ct.user_id == ^user_id)
      |> Repo.all()
    {:ok, result}
  end
end
