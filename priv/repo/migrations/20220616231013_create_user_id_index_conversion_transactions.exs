defmodule CurrencyConvertexApi.Repo.Migrations.CreateUserIdIndexConversionTransactions do
  use Ecto.Migration

  def change do
    create index(:conversion_transactions, [:user_id])
  end
end
