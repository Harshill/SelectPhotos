defmodule SelectPhotos.AlternateGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "alternate_groups" do
    has_many :photos, SelectPhotos.Photo
    timestamps()
  end

  def changeset(group, attrs) do
    group
    |> cast(attrs, [])
  end
end
