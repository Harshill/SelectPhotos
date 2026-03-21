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

      # Generate thumbnails in the background (skip in test)
      unless Application.get_env(:select_photos, :skip_thumbnails, false) do
        Task.start(fn -> SelectPhotos.Thumbnailer.generate_all(directory) end)
      end

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

  def remove_from_group_keep_status(%Photo{} = photo) do
    photo
    |> Photo.changeset(%{alternate_group_id: nil, is_primary: false})
    |> Repo.update()
  end

  def get_group_with_photos(group_id) do
    AlternateGroup
    |> Repo.get!(group_id)
    |> Repo.preload(photos: from(p in Photo, order_by: [desc: p.is_primary, asc: p.position]))
  end

  @doc """
  Counts alternate groups that still have more than 1 photo (unresolved).
  """
  def unresolved_alternate_group_count(directory) do
    AlternateGroup
    |> join(:inner, [g], p in Photo, on: p.alternate_group_id == g.id)
    |> where([g, p], p.directory == ^directory)
    |> group_by([g, p], g.id)
    |> having([g, p], count(p.id) > 1)
    |> select([g, p], g.id)
    |> Repo.all()
    |> length()
  end

  @doc """
  Lists alternate groups that have more than 1 photo (i.e. actually have alternates to compare).
  """
  def list_alternate_groups(directory) do
    group_ids =
      Photo
      |> where([p], p.directory == ^directory and not is_nil(p.alternate_group_id))
      |> group_by([p], p.alternate_group_id)
      |> having([p], count(p.id) > 1)
      |> select([p], p.alternate_group_id)
      |> Repo.all()

    AlternateGroup
    |> where([g], g.id in ^group_ids)
    |> preload(photos: ^from(p in Photo, order_by: [desc: p.is_primary, asc: p.position]))
    |> Repo.all()
  end

  # --- Tournament ---

  alias SelectPhotos.TournamentMatch

  def get_match!(id) do
    TournamentMatch
    |> Repo.get!(id)
    |> Repo.preload([:photo_left, :photo_right])
  end

  @doc """
  Generates round 1 matches by shuffling selected photos into pairs.
  If odd number, last photo gets a bye (auto-advances).
  Returns {:ok, matches} or {:error, reason}.
  """
  def start_tournament(directory, target \\ 25) do
    selected = list_selected(directory)
    count = length(selected)

    cond do
      count <= target ->
        {:error, :not_enough_photos}

      true ->
        # Clear any existing tournament matches
        Repo.delete_all(TournamentMatch)

        shuffled = Enum.shuffle(selected)
        matches = create_round_matches(shuffled, 1)
        {:ok, matches}
    end
  end

  defp create_round_matches(photos, round) do
    photos
    |> Enum.chunk_every(2)
    |> Enum.with_index(1)
    |> Enum.map(fn
      {[left, right], position} ->
        {:ok, match} =
          %TournamentMatch{}
          |> TournamentMatch.changeset(%{
            round: round,
            position: position,
            photo_left_id: left.id,
            photo_right_id: right.id
          })
          |> Repo.insert()

        match

      {[bye], position} ->
        # Odd photo gets a bye — auto-win
        {:ok, match} =
          %TournamentMatch{}
          |> TournamentMatch.changeset(%{
            round: round,
            position: position,
            photo_left_id: bye.id,
            photo_right_id: bye.id,
            winner_id: bye.id
          })
          |> Repo.insert()

        match
    end)
  end

  def pick_winner(%TournamentMatch{} = match, %Photo{} = winner) do
    match
    |> TournamentMatch.changeset(%{winner_id: winner.id})
    |> Repo.update()
  end

  def current_match(round) do
    TournamentMatch
    |> where([m], m.round == ^round and is_nil(m.winner_id))
    |> order_by([m], asc: m.position)
    |> limit(1)
    |> Repo.one()
    |> Repo.preload([:photo_left, :photo_right])
  end

  def round_complete?(round) do
    TournamentMatch
    |> where([m], m.round == ^round and is_nil(m.winner_id))
    |> Repo.aggregate(:count) == 0
  end

  def round_winners(round) do
    TournamentMatch
    |> where([m], m.round == ^round)
    |> Repo.all()
    |> Repo.preload(:winner)
    |> Enum.map(& &1.winner)
  end

  def advance_round(round, target) do
    winners = round_winners(round)

    if length(winners) <= target do
      {:done, winners}
    else
      next_round = round + 1
      matches = create_round_matches(Enum.shuffle(winners), next_round)
      {:next, next_round, matches}
    end
  end

  def round_stats(round) do
    total =
      TournamentMatch
      |> where([m], m.round == ^round)
      |> Repo.aggregate(:count)

    completed =
      TournamentMatch
      |> where([m], m.round == ^round and not is_nil(m.winner_id))
      |> Repo.aggregate(:count)

    %{total: total, completed: completed, remaining: total - completed}
  end

  def clear_tournament do
    Repo.delete_all(TournamentMatch)
  end
end
