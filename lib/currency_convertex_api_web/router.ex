defmodule CurrencyConvertexApiWeb.Router do
  use CurrencyConvertexApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CurrencyConvertexApiWeb.Plugs.UuidChecker
  end

  pipeline :auth do
    plug CurrencyConvertexApiWeb.Auth.Pipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/api/v1", CurrencyConvertexApiWeb do
    pipe_through [:api, :auth, :ensure_auth]

    post "/conversion-transactions", ConversionTransactionsController, :create

    get "/conversion-transactions/:user_id", ConversionTransactionsController, :show

    get "/users/:id", UsersController, :show
  end

  scope "/api/v1", CurrencyConvertexApiWeb do
    pipe_through [:api, :auth]

    post "/users", UsersController, :create

    post "/signin", UsersController, :sign_in
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CurrencyConvertexApiWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
