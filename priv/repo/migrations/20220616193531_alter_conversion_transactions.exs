defmodule CurrencyConvertexApi.Repo.Migrations.AlterConversionTransactions do
  use Ecto.Migration

  def change do
    alter table :conversion_transactions do
      modify :created_at, :utc_datetime
      modify :origin_currency, :string, size: 3
      modify :destiny_currency, :string,  size: 3
    end
  end
end
