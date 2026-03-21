defmodule SelectPhotos.TournamentTest do
  use SelectPhotos.DataCase

  alias SelectPhotos.Gallery

  @test_dir System.tmp_dir!() |> Path.join("select_photos_tournament_test")

  setup do
    File.rm_rf!(@test_dir)
    File.mkdir_p!(@test_dir)

    # Create 10 fake images
    for i <- 1..10 do
      File.write!(Path.join(@test_dir, "IMG_#{String.pad_leading("#{i}", 3, "0")}.jpg"), "fake")
    end

    Gallery.load_from_directory(@test_dir)

    # Select all 10
    Gallery.list_photos(@test_dir)
    |> Enum.each(&Gallery.select_photo/1)

    on_exit(fn -> File.rm_rf!(@test_dir) end)
    :ok
  end

  test "start_tournament fails if not enough photos" do
    assert {:error, :not_enough_photos} = Gallery.start_tournament(@test_dir, 25)
  end

  test "start_tournament creates matches for round 1" do
    {:ok, matches} = Gallery.start_tournament(@test_dir, 4)
    assert length(matches) == 5
    assert Enum.all?(matches, &(&1.round == 1))
  end

  test "full tournament flow" do
    {:ok, _matches} = Gallery.start_tournament(@test_dir, 4)

    # Play through round 1
    play_round(1)
    assert Gallery.round_complete?(1)

    # Advance
    case Gallery.advance_round(1, 4) do
      {:done, winners} ->
        assert length(winners) <= 4

      {:next, 2, _matches} ->
        play_round(2)

        case Gallery.advance_round(2, 4) do
          {:done, winners} -> assert length(winners) <= 4
          {:next, 3, _} -> :ok
        end
    end
  end

  test "pick_winner records the winner" do
    {:ok, _} = Gallery.start_tournament(@test_dir, 4)
    match = Gallery.current_match(1)
    assert match != nil

    {:ok, updated} = Gallery.pick_winner(match, match.photo_left)
    assert updated.winner_id == match.photo_left.id
  end

  test "clear_tournament removes all matches" do
    {:ok, _} = Gallery.start_tournament(@test_dir, 4)
    Gallery.clear_tournament()
    assert Gallery.current_match(1) == nil
  end

  defp play_round(round) do
    case Gallery.current_match(round) do
      nil -> :ok
      match ->
        Gallery.pick_winner(match, match.photo_left)
        play_round(round)
    end
  end
end
