defmodule SelectPhotosWeb.Router do
  use SelectPhotosWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SelectPhotosWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SelectPhotosWeb do
    pipe_through :browser

    live "/", DashboardLive
    live "/gallery", GalleryLive
    live "/compare", ComparisonLive
    live "/tournament", TournamentLive
    live "/export", ExportLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", SelectPhotosWeb do
  #   pipe_through :api
  # end
end
