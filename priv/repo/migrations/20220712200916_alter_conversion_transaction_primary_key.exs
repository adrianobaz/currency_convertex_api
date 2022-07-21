defmodule CurrencyConvertexApi.Repo.Migrations.AlterConversionTransactionPrimaryKey do
  use Ecto.Migration

  def change do
    alter table(:conversion_transactions, primary_key: false) do
      remove :id
      add :id, :binary_id, primary_key: true
    end
  end
end
