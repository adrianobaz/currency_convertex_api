defmodule CurrencyConvertexApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :currency_convertex_api,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CurrencyConvertexApi.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.6.8"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.6"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_dashboard, "~> 0.6"},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.18"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.5"},

      # Testing
      {:credo, "~> 1.6.0", only: [:dev, :test], runtime: false},
      {:ex_machina, "~> 2.7.0"},
      {:excoveralls, "~> 0.14.5", only: :test},
      {:mimic, "~> 1.7", only: :test},
      {:sobelow, "~> 0.8", only: :dev},
      {:dialyxir, "~> 1.1.0", only: [:dev, :test], runtime: false},

      # {:exvcr, "~> 0.12.2", only: :test},
      # {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      # {:husky, "~> 1.0", only: :dev, runtime: false},
      # {:benchee, "~> 1.0", only: :dev},
      # {:espec_phoenix, "~> 0.8.2", only: :test},

      # Others
      {:tesla, "~> 1.4.4"},
      {:hackney, "~> 1.18.0"},
      {:tarams, "~> 1.6.1"},
      {:argon2_elixir, "~> 3.0"},
      {:guardian, "~> 2.2.4"},
      {:oban, "~> 2.13"}

      # {:fun_with_flags, "~> 1.8"},
      # {:ex_crypto, "~> 0.10.0"},
      # {:latinizer, "~> 0.4.0"},
      # {:tzdata, "~> 1.1"},
      # {:brcpfcnpj, "~> 1.0.0"}
      # {:appsignal, "~> 2.2", override: true}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
