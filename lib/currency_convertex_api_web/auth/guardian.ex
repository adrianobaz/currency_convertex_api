defmodule CurrencyConvertexApiWeb.Auth.Guardian do
  use Guardian, otp_app: :currency_convertex_api

  alias CurrencyConvertexApi.{Error, User}
  alias CurrencyConvertexApi.Users.Get, as: UserGet

  def subject_for_token(%User{id: id}, _claims), do: {:ok, id}
  def subject_for_token(_, _), do: {:error, "Unknown resource type"}

  def resource_from_claims(%{"sub" => id}), do: {:ok, UserGet.by_id(id)}
  def resource_from_claims(_claims), do: {:error, "Unknown resource type"}

  def authenticate(%{"id" => user_id, "password" => password}) do
    with {:ok, %User{password_hash: hash} = user} <- UserGet.by_id(user_id),
         true <- Argon2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Please verify your credentials!")}
      any -> any
    end
  end

  def authenticate(_), do: {:error, Error.build(:bad_request, "Invalid or missing params!")}
end
