defmodule SelectPhotos.Repo do
  use Ecto.Repo,
    otp_app: :select_photos,
    adapter: Ecto.Adapters.SQLite3
end
