defmodule FridaWeb.StatusLiveTest do
  use FridaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Frida.Posts

  @create_attrs %{color: "some color", name: "some name", order: 42}
  @update_attrs %{color: "some updated color", name: "some updated name", order: 43}
  @invalid_attrs %{color: nil, name: nil, order: nil}

  defp fixture(:status) do
    {:ok, status} = Posts.create_status(@create_attrs)
    status
  end

  defp create_status(_) do
    status = fixture(:status)
    %{status: status}
  end

  describe "Index" do
    setup [:create_status]

    test "lists all status", %{conn: conn, status: status} do
      {:ok, _index_live, html} = live(conn, Routes.status_index_path(conn, :index))

      assert html =~ "Listing Status"
      assert html =~ status.color
    end

    test "saves new status", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.status_index_path(conn, :index))

      assert index_live |> element("a", "New Status") |> render_click() =~
               "New Status"

      assert_patch(index_live, Routes.status_index_path(conn, :new))

      assert index_live
             |> form("#status-form", status: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#status-form", status: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.status_index_path(conn, :index))

      assert html =~ "Status created successfully"
      assert html =~ "some color"
    end

    test "updates status in listing", %{conn: conn, status: status} do
      {:ok, index_live, _html} = live(conn, Routes.status_index_path(conn, :index))

      assert index_live |> element("#status-#{status.id} a", "Edit") |> render_click() =~
               "Edit Status"

      assert_patch(index_live, Routes.status_index_path(conn, :edit, status))

      assert index_live
             |> form("#status-form", status: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#status-form", status: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.status_index_path(conn, :index))

      assert html =~ "Status updated successfully"
      assert html =~ "some updated color"
    end

    test "deletes status in listing", %{conn: conn, status: status} do
      {:ok, index_live, _html} = live(conn, Routes.status_index_path(conn, :index))

      assert index_live |> element("#status-#{status.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#status-#{status.id}")
    end
  end

  describe "Show" do
    setup [:create_status]

    test "displays status", %{conn: conn, status: status} do
      {:ok, _show_live, html} = live(conn, Routes.status_show_path(conn, :show, status))

      assert html =~ "Show Status"
      assert html =~ status.color
    end

    test "updates status within modal", %{conn: conn, status: status} do
      {:ok, show_live, _html} = live(conn, Routes.status_show_path(conn, :show, status))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Status"

      assert_patch(show_live, Routes.status_show_path(conn, :edit, status))

      assert show_live
             |> form("#status-form", status: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#status-form", status: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.status_show_path(conn, :show, status))

      assert html =~ "Status updated successfully"
      assert html =~ "some updated color"
    end
  end
end
