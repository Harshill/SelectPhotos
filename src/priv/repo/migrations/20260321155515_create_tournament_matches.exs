defmodule SelectPhotos.Repo.Migrations.CreateTournamentMatches do
  use Ecto.Migration

  def change do
    create table(:tournament_matches) do
      add :round, :integer, null: false
      add :position, :integer, null: false
      add :photo_left_id, references(:photos, on_delete: :delete_all), null: false
      add :photo_right_id, references(:photos, on_delete: :delete_all), null: false
      add :winner_id, references(:photos, on_delete: :nilify_all)

      timestamps()
    end

    create index(:tournament_matches, [:round])
    create index(:tournament_matches, [:photo_left_id])
    create index(:tournament_matches, [:photo_right_id])
  end
end
