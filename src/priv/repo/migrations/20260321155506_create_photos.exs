defmodule SelectPhotos.Repo.Migrations.CreatePhotos do
  use Ecto.Migration

  def change do
    create table(:photos) do
      add :filename, :string, null: false
      add :directory, :string, null: false
      add :position, :integer
      add :status, :string, null: false, default: "unreviewed"
      add :is_primary, :boolean, null: false, default: false
      add :metadata, :map, default: %{}

      timestamps()
    end

    create unique_index(:photos, [:directory, :filename])
    create index(:photos, [:status])
  end
end
