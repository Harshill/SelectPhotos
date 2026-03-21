defmodule SelectPhotos.Gallery do
  @moduledoc """
  Context for managing photos, selections, and alternate groups.
  """

  import Ecto.Query
  alias SelectPhotos.Repo
  alias SelectPhotos.Photo
  alias SelectPhotos.AlternateGroup

  @image_extensions ~w(.jpg .jpeg .png .tiff .tif .bmp .webp .heic .heif .raw .cr2 .nef .arw .dng)

  # --- Loading photos from disk ---

  def load_from_directory(directory) do
    directory = Path.expand(directory)

    unless File.dir?(directory) do
      {:error, :not_a_directory}
    else
      files =
        directory
        |> File.ls!()
        |> Enum.filter(&image_file?/1)
        |> Enum.sort()

      now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

      entries =
        files
        |> Enum.with_index(1)
        |> Enum.map(fn {filename, position} ->
          %{
            filename: filename,
            directory: directory,
            position: position,
            status: "unreviewed",
            is_primary: false,
            metadata: %{},
            inserted_at: now,
            updated_at: now
          }
        end)

      Repo.insert_all(Photo, entries, on_conflict: :nothing)
      {:ok, length(entries)}
    end
  end

  defp image_file?(filename) do
    ext = filename |> Path.extname() |> String.downcase()
    ext in @image_extensions
  end

  # --- Querying photos ---

  def list_photos(directory) do
    Photo
    |> where([p], p.directory == ^directory)
    |> order_by([p], asc: p.position)
    |> Repo.all()
  end

  def get_photo!(id), do: Repo.get!(Photo, id)

  def list_selected(directory) do
    Photo
    |> where([p], p.directory == ^directory and p.status == "selected")
    |> order_by([p], asc: p.position)
    |> Repo.all()
  end

  def selected_count(directory) do
    Photo
    |> where([p], p.directory == ^directory and p.status == "selected")
    |> Repo.aggregate(:count)
  end

  # --- Selection ---

  def select_photo(%Photo{} = photo) do
    photo
    |> Photo.changeset(%{status: "selected"})
    |> Repo.update()
  end

  def deselect_photo(%Photo{} = photo) do
    photo
    |> Photo.changeset(%{status: "unreviewed", is_primary: false, alternate_group_id: nil})
    |> Repo.update()
  end

  def reject_photo(%Photo{} = photo) do
    photo
    |> Photo.changeset(%{status: "rejected"})
    |> Repo.update()
  end

  # --- Alternate Groups ---

  def create_alternate_group(%Photo{} = primary_photo) do
    Repo.transaction(fn ->
      {:ok, group} = %AlternateGroup{} |> Repo.insert()

      {:ok, updated_photo} =
        primary_photo
        |> Photo.changeset(%{alternate_group_id: group.id, is_primary: true, status: "selected"})
        |> Repo.update()

      {group, updated_photo}
    end)
  end

  def add_alternate(%AlternateGroup{} = group, %Photo{} = photo) do
    photo
    |> Photo.changeset(%{alternate_group_id: group.id, is_primary: false, status: "alternate"})
    |> Repo.update()
  end

  def swap_primary(%AlternateGroup{} = group, %Photo{} = new_primary) do
    Repo.transaction(fn ->
      # Demote current primary to alternate
      Photo
      |> where([p], p.alternate_group_id == ^group.id and p.is_primary == true)
      |> Repo.update_all(set: [is_primary: false, status: "alternate"])

      # Promote new primary
      {:ok, promoted} =
        new_primary
        |> Photo.changeset(%{is_primary: true, status: "selected"})
        |> Repo.update()

      promoted
    end)
  end

  def remove_from_group(%Photo{} = photo) do
    photo
    |> Photo.changeset(%{alternate_group_id: nil, is_primary: false, status: "unreviewed"})
    |> Repo.update()
  end

  def get_group_with_photos(group_id) do
    AlternateGroup
    |> Repo.get!(group_id)
    |> Repo.preload(photos: from(p in Photo, order_by: [desc: p.is_primary, asc: p.position]))
  end

  def list_alternate_groups(directory) do
    AlternateGroup
    |> join(:inner, [g], p in Photo, on: p.alternate_group_id == g.id)
    |> where([g, p], p.directory == ^directory)
    |> distinct(true)
    |> preload(photos: ^from(p in Photo, order_by: [desc: p.is_primary, asc: p.position]))
    |> Repo.all()
  end
end
