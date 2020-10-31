defmodule FridaWeb.FeedbackLiveTest do
  use FridaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Frida.Feedbacks

  @create_attrs %{created_at: "2010-04-17T14:00:00Z", details: "some details", title: "some title"}
  @update_attrs %{created_at: "2011-05-18T15:01:01Z", details: "some updated details", title: "some updated title"}
  @invalid_attrs %{created_at: nil, details: nil, title: nil}

  defp fixture(:feedback) do
    {:ok, feedback} = Feedbacks.create_feedback(@create_attrs)
    feedback
  end

  defp create_feedback(_) do
    feedback = fixture(:feedback)
    %{feedback: feedback}
  end

  describe "Index" do
    setup [:create_feedback]

    test "lists all feedbacks", %{conn: conn, feedback: feedback} do
      {:ok, _index_live, html} = live(conn, Routes.feedback_index_path(conn, :index))

      assert html =~ "Listing Feedbacks"
      assert html =~ feedback.details
    end

    test "saves new feedback", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.feedback_index_path(conn, :index))

      assert index_live |> element("a", "New Feedback") |> render_click() =~
               "New Feedback"

      assert_patch(index_live, Routes.feedback_index_path(conn, :new))

      assert index_live
             |> form("#feedback-form", feedback: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#feedback-form", feedback: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.feedback_index_path(conn, :index))

      assert html =~ "Feedback created successfully"
      assert html =~ "some details"
    end

    test "updates feedback in listing", %{conn: conn, feedback: feedback} do
      {:ok, index_live, _html} = live(conn, Routes.feedback_index_path(conn, :index))

      assert index_live |> element("#feedback-#{feedback.id} a", "Edit") |> render_click() =~
               "Edit Feedback"

      assert_patch(index_live, Routes.feedback_index_path(conn, :edit, feedback))

      assert index_live
             |> form("#feedback-form", feedback: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#feedback-form", feedback: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.feedback_index_path(conn, :index))

      assert html =~ "Feedback updated successfully"
      assert html =~ "some updated details"
    end

    test "deletes feedback in listing", %{conn: conn, feedback: feedback} do
      {:ok, index_live, _html} = live(conn, Routes.feedback_index_path(conn, :index))

      assert index_live |> element("#feedback-#{feedback.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#feedback-#{feedback.id}")
    end
  end

  describe "Show" do
    setup [:create_feedback]

    test "displays feedback", %{conn: conn, feedback: feedback} do
      {:ok, _show_live, html} = live(conn, Routes.feedback_show_path(conn, :show, feedback))

      assert html =~ "Show Feedback"
      assert html =~ feedback.details
    end

    test "updates feedback within modal", %{conn: conn, feedback: feedback} do
      {:ok, show_live, _html} = live(conn, Routes.feedback_show_path(conn, :show, feedback))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Feedback"

      assert_patch(show_live, Routes.feedback_show_path(conn, :edit, feedback))

      assert show_live
             |> form("#feedback-form", feedback: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#feedback-form", feedback: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.feedback_show_path(conn, :show, feedback))

      assert html =~ "Feedback updated successfully"
      assert html =~ "some updated details"
    end
  end
end
