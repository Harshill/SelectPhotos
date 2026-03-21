defmodule SelectPhotos.TournamentMatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tournament_matches" do
    field :round, :integer
    field :position, :integer

    belongs_to :photo_left, SelectPhotos.Photo
    belongs_to :photo_right, SelectPhotos.Photo
    belongs_to :winner, SelectPhotos.Photo

    timestamps()
  end

  def changeset(match, attrs) do
    match
    |> cast(attrs, [:round, :position, :photo_left_id, :photo_right_id, :winner_id])
    |> validate_required([:round, :position, :photo_left_id, :photo_right_id])
  end
end
