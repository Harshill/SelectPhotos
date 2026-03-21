defmodule SelectPhotos.Repo.Migrations.CreateAlternateGroups do
  use Ecto.Migration

  def change do
    create table(:alternate_groups) do
      timestamps()
    end

    alter table(:photos) do
      add :alternate_group_id, references(:alternate_groups, on_delete: :nilify_all)
    end

    create index(:photos, [:alternate_group_id])
  end
end
