defmodule FridaWeb.FeedbacksLive do
  use FridaWeb, :live_view

  alias Frida.Feedbacks
  alias Frida.Feedbacks.Feedback

  @impl true
  def mount(_params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign(:feedback, %Feedback{})
      |> assign_feedbacks()

    {:ok, socket}
  end

  @impl true
  def handle_info({:like, feedback}, socket) do
    Frida.Feedbacks.like_feedback(feedback, socket.assigns.current_user)
    socket = assign_feedbacks(socket)
    {:noreply, socket}
  end

  defp assign_feedbacks(socket) do
    feedbacks = Feedbacks.list_feedbacks()
    assign(socket, :feedbacks, feedbacks)
  end
end
