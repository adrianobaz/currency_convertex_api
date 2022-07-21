defmodule CurrencyConvertexApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :currency_convertex_api

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end
