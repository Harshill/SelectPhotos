defmodule SelectPhotos.GalleryTest do
  use SelectPhotos.DataCase

  alias SelectPhotos.Gallery
  alias SelectPhotos.Photo

  @test_dir System.tmp_dir!() |> Path.join("select_photos_test")

  setup do
    File.rm_rf!(@test_dir)
    File.mkdir_p!(@test_dir)

    # Create some fake image files
    for name <- ~w(IMG_001.jpg IMG_002.jpg IMG_003.jpg IMG_004.jpg IMG_005.jpg) do
      File.write!(Path.join(@test_dir, name), "fake image data")
    end

    # Create a non-image file that should be ignored
    File.write!(Path.join(@test_dir, "notes.txt"), "not a photo")

    on_exit(fn -> File.rm_rf!(@test_dir) end)
    :ok
  end

  describe "load_from_directory/1" do
    test "loads image files and ignores non-images" do
      assert {:ok, 5} = Gallery.load_from_directory(@test_dir)
      photos = Gallery.list_photos(@test_dir)
      assert length(photos) == 5
      assert Enum.all?(photos, &(&1.status == "unreviewed"))
    end

    test "assigns sequential positions" do
      Gallery.load_from_directory(@test_dir)
      photos = Gallery.list_photos(@test_dir)
      positions = Enum.map(photos, & &1.position)
      assert positions == [1, 2, 3, 4, 5]
    end

    test "returns error for non-existent directory" do
      assert {:error, :not_a_directory} = Gallery.load_from_directory("/nope/not/real")
    end

    test "does not duplicate on re-load" do
      Gallery.load_from_directory(@test_dir)
      Gallery.load_from_directory(@test_dir)
      assert length(Gallery.list_photos(@test_dir)) == 5
    end
  end

  describe "select/deselect/reject" do
    setup do
      Gallery.load_from_directory(@test_dir)
      photo = Gallery.list_photos(@test_dir) |> hd()
      %{photo: photo}
    end

    test "select_photo sets status to selected", %{photo: photo} do
      {:ok, updated} = Gallery.select_photo(photo)
      assert updated.status == "selected"
    end

    test "deselect_photo resets status and clears group", %{photo: photo} do
      {:ok, selected} = Gallery.select_photo(photo)
      {:ok, deselected} = Gallery.deselect_photo(selected)
      assert deselected.status == "unreviewed"
      assert deselected.is_primary == false
      assert deselected.alternate_group_id == nil
    end

    test "reject_photo sets status to rejected", %{photo: photo} do
      {:ok, rejected} = Gallery.reject_photo(photo)
      assert rejected.status == "rejected"
    end

    test "selected_count reflects selections" do
      photos = Gallery.list_photos(@test_dir)
      assert Gallery.selected_count(@test_dir) == 0

      Gallery.select_photo(Enum.at(photos, 0))
      Gallery.select_photo(Enum.at(photos, 1))
      assert Gallery.selected_count(@test_dir) == 2
    end
  end

  describe "alternate groups" do
    setup do
      Gallery.load_from_directory(@test_dir)
      photos = Gallery.list_photos(@test_dir)
      %{photos: photos}
    end

    test "create group and add alternates", %{photos: photos} do
      [p1, p2, p3 | _] = photos

      {:ok, {group, primary}} = Gallery.create_alternate_group(p1)
      assert primary.is_primary == true
      assert primary.status == "selected"
      assert primary.alternate_group_id == group.id

      {:ok, alt1} = Gallery.add_alternate(group, p2)
      assert alt1.status == "alternate"
      assert alt1.is_primary == false

      {:ok, alt2} = Gallery.add_alternate(group, p3)
      assert alt2.status == "alternate"

      loaded = Gallery.get_group_with_photos(group.id)
      assert length(loaded.photos) == 3
      assert hd(loaded.photos).is_primary == true
    end

    test "swap primary demotes old and promotes new", %{photos: photos} do
      [p1, p2, p3 | _] = photos

      {:ok, {group, _primary}} = Gallery.create_alternate_group(p1)
      {:ok, _} = Gallery.add_alternate(group, p2)
      {:ok, _} = Gallery.add_alternate(group, p3)

      # Swap p2 to primary
      alt2 = Repo.get!(Photo, p2.id)
      {:ok, new_primary} = Gallery.swap_primary(group, alt2)
      assert new_primary.is_primary == true
      assert new_primary.status == "selected"

      # Old primary should now be an alternate
      old_primary = Repo.get!(Photo, p1.id)
      assert old_primary.is_primary == false
      assert old_primary.status == "alternate"
    end

    test "remove_from_group resets photo", %{photos: photos} do
      [p1, p2 | _] = photos

      {:ok, {group, _}} = Gallery.create_alternate_group(p1)
      {:ok, alt} = Gallery.add_alternate(group, p2)

      {:ok, removed} = Gallery.remove_from_group(alt)
      assert removed.alternate_group_id == nil
      assert removed.status == "unreviewed"
    end
  end
end
