defmodule CurrencyConvertexApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      CurrencyConvertexApi.Repo,
      # Start the Telemetry supervisor
      CurrencyConvertexApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: CurrencyConvertexApi.PubSub},
      # Start the Endpoint (http/https)
      CurrencyConvertexApiWeb.Endpoint
      # Start a worker by calling: CurrencyConvertexApi.Worker.start_link(arg)
      # {CurrencyConvertexApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CurrencyConvertexApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CurrencyConvertexApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
