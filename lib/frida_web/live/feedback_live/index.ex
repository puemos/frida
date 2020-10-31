defmodule FridaWeb.FeedbackLive.Index do
  use FridaWeb, :live_view

  alias Frida.Feedbacks
  alias Frida.Feedbacks.Feedback

  @impl true
  def mount(_params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign(:feedback, %Feedback{})
      |> assign(:feedbacks, list_feedbacks())
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Feedback")
    |> assign(:feedback, Feedbacks.get_feedback!(id))
  end

  defp apply_action(socket, :index, _params) do
    socket
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    feedback = Feedbacks.get_feedback!(id)
    {:ok, _} = Feedbacks.delete_feedback(feedback)

    {:noreply, assign(socket, :feedbacks, list_feedbacks())}
  end

  defp list_feedbacks do
    Feedbacks.list_feedbacks()
  end
end
