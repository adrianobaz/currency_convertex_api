defmodule CurrencyConvertexApi.Users.Create do
  alias CurrencyConvertexApi.{Repo, Error}
  alias CurrencyConvertexApi.User

  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> case do
      {:ok, %User{}} = result -> result
      {:error, changeset} -> {:error, Error.build(:bad_request, changeset)}
    end
  end
end
