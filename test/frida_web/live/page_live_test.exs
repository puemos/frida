defmodule FridaWeb.PageLiveTest do
  use FridaWeb.ConnCase

  import Phoenix.LiveViewTest

  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Boilerplate Generator"
    assert render(page_live) =~ "Boilerplate Generator"
  end
end
