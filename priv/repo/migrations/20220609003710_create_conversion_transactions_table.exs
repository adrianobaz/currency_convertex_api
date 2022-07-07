defmodule CurrencyConvertexApi.Repo.Migrations.CreateConversionTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:conversion_transactions) do
      add :user_id, :integer
      add :origin_currency, :string, size: 5
      add :origin_value, :decimal
      add :destiny_currency, :string, size: 5
      add :conversion_rate, :decimal

      timestamps(inserted_at: :created_at, updated_at: false)
    end

    create unique_index(:conversion_transactions, [:user_id])
  end
end
