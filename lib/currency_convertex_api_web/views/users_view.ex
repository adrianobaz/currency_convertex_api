defmodule CurrencyConvertexApiWeb.UsersView do
  use CurrencyConvertexApiWeb, :view

  alias CurrencyConvertexApi.User

  def render("create.json", %{token: token, user: %User{id: id, name: name}}) do
    %{
      token: token,
      name: name,
      id: id
    }
  end

  def render("user.json", %{user: %User{} = user}), do: user

  def render("sign_in.json", %{token: token}), do: %{token: token}
end
