defmodule SelectPhotosWeb.PageControllerTest do
  use SelectPhotosWeb.ConnCase

  test "GET / renders gallery", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "The Digital Darkroom"
  end
end
