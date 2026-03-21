defmodule SelectPhotos.Photo do
  use Ecto.Schema
  import Ecto.Changeset

  @statuses ~w(unreviewed selected rejected alternate)

  schema "photos" do
    field :filename, :string
    field :directory, :string
    field :position, :integer
    field :status, :string, default: "unreviewed"
    field :is_primary, :boolean, default: false
    field :metadata, :map, default: %{}

    belongs_to :alternate_group, SelectPhotos.AlternateGroup

    timestamps()
  end

  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:filename, :directory, :position, :status, :is_primary, :metadata, :alternate_group_id])
    |> validate_required([:filename, :directory])
    |> validate_inclusion(:status, @statuses)
    |> unique_constraint([:directory, :filename])
  end
end
