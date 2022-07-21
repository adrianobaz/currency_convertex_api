defmodule CurrencyConvertexApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :password_hash, :string

      timestamps(inserted_at: :created_at, updated_at: false, type: :utc_datetime)
    end
  end
end
