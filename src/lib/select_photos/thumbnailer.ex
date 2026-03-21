defmodule SelectPhotos.Thumbnailer do
  @moduledoc """
  Generates and serves thumbnails for photos.
  Thumbnails are cached in a .thumbs directory inside the photo directory.
  """

  @thumb_size 400
  @thumb_quality 80

  def thumb_dir(directory) do
    Path.join(directory, ".thumbs")
  end

  def thumb_path(directory, filename) do
    Path.join(thumb_dir(directory), filename)
  end

  @doc """
  Returns the path to a thumbnail, generating it if it doesn't exist.
  """
  def get_or_create(directory, filename) do
    thumb = thumb_path(directory, thumb_filename(filename))

    if File.exists?(thumb) do
      {:ok, thumb}
    else
      generate(directory, filename)
    end
  end

  @doc """
  Generates a thumbnail for a single photo.
  """
  def generate(directory, filename) do
    source = Path.join(directory, filename)
    dest_dir = thumb_dir(directory)
    dest = Path.join(dest_dir, thumb_filename(filename))

    File.mkdir_p!(dest_dir)

    case Image.thumbnail(source, @thumb_size) do
      {:ok, thumb} ->
        case Image.write(thumb, dest, quality: @thumb_quality, strip_metadata: true) do
          {:ok, _} -> {:ok, dest}
          {:error, reason} -> {:error, reason}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Generates thumbnails for all photos in a directory.
  Returns {success_count, error_count}.
  """
  def generate_all(directory) do
    dest_dir = thumb_dir(directory)
    File.mkdir_p!(dest_dir)

    directory
    |> File.ls!()
    |> Enum.filter(&image_file?/1)
    |> Task.async_stream(
      fn filename ->
        thumb = thumb_path(dest_dir, thumb_filename(filename))

        if File.exists?(thumb) do
          :skip
        else
          case generate(directory, filename) do
            {:ok, _} -> :ok
            {:error, _} -> :error
          end
        end
      end,
      max_concurrency: System.schedulers_online(),
      timeout: 30_000
    )
    |> Enum.reduce({0, 0}, fn
      {:ok, :ok}, {s, e} -> {s + 1, e}
      {:ok, :skip}, {s, e} -> {s, e}
      _, {s, e} -> {s, e + 1}
    end)
  end

  # Convert any input filename to a .jpg thumbnail filename
  defp thumb_filename(filename) do
    base = Path.rootname(filename)
    "#{base}_thumb.jpg"
  end

  @image_extensions ~w(.jpg .jpeg .png .tiff .tif .bmp .webp .heic .heif .raw .cr2 .nef .arw .dng)

  defp image_file?(filename) do
    ext = filename |> Path.extname() |> String.downcase()
    ext in @image_extensions
  end
end
