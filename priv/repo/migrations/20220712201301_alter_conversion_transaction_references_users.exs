defmodule CurrencyConvertexApi.Repo.Migrations.AlterConversionTransactionReferencesUsers do
  use Ecto.Migration

  def change do
    alter table(:conversion_transactions) do
      remove :user_id
      add :user_id, references(:users, type: :binary_id)
    end
  end
end
