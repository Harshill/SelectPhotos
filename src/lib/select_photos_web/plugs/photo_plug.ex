defmodule SelectPhotosWeb.PhotoPlug do
  @moduledoc """
  Serves photo files from the configured photo directory.
  GET /photos/:filename — serves full-resolution image
  GET /thumbs/:filename — serves thumbnail (generates on first request)
  """
  import Plug.Conn

  alias SelectPhotos.Thumbnailer

  def init(opts), do: opts

  def call(%{path_info: ["photos", filename]} = conn, _opts) do
    directory = Application.get_env(:select_photos, :photo_directory, "")
    file_path = Path.join(directory, filename)

    if File.exists?(file_path) do
      conn
      |> put_resp_content_type(MIME.from_path(filename))
      |> send_file(200, file_path)
      |> halt()
    else
      conn |> send_resp(404, "Not found") |> halt()
    end
  end

  def call(%{path_info: ["thumbs", filename]} = conn, _opts) do
    directory = Application.get_env(:select_photos, :photo_directory, "")

    case Thumbnailer.get_or_create(directory, filename) do
      {:ok, thumb_path} ->
        conn
        |> put_resp_content_type("image/jpeg")
        |> send_file(200, thumb_path)
        |> halt()

      {:error, _reason} ->
        # Fall back to full image
        file_path = Path.join(directory, filename)

        if File.exists?(file_path) do
          conn
          |> put_resp_content_type(MIME.from_path(filename))
          |> send_file(200, file_path)
          |> halt()
        else
          conn |> send_resp(404, "Not found") |> halt()
        end
    end
  end

  def call(conn, _opts), do: conn
end
