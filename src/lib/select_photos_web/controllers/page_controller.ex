defmodule SelectPhotosWeb.PageController do
  use SelectPhotosWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
