defmodule CurrencyConvertexApi.Repo.Migrations.AddObanJobsTable do
  use Ecto.Migration

  def change do
    Oban.Migrations.up(version: 11)
  end

  def down do
    Oban.Migrations.down(version: 1)
  end
end
