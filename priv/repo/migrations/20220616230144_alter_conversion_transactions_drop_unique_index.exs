defmodule CurrencyConvertexApi.Repo.Migrations.AlterConversionTransactionsDropUniqueIndex do
  use Ecto.Migration

  def change do
    drop index(:conversion_transactions, [:user_id]), mode: :cascade
  end
end
