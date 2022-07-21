defmodule CurrencyConvertexApi.Users.Get do
  alias CurrencyConvertexApi.{Repo, Error}
  alias CurrencyConvertexApi.User

  def by_id(user_id) when is_binary(user_id) do
    case Repo.get(User, user_id) do
      nil -> {:error, Error.build(:not_found, "User not found!")}
      user_schema -> {:ok, user_schema}
    end
  end
end
