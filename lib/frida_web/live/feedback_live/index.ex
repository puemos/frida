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
  # def handle_event("like", %{"id" => id}, socket) do
  #   # Frida.Feedbacks.like_feedback(feedback, socket.assigns.current_user)
  #   IO.inspect(id)
  #   {:noreply, socket}
  # end

  def handle_info({:like, feedback}, socket) do
    Frida.Feedbacks.like_feedback(feedback, socket.assigns.current_user)
    socket = assign(socket, :feedbacks, list_feedbacks())
    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
  end

  defp list_feedbacks do
    feedbacks = Feedbacks.list_feedbacks()
    feedbacks
  end
end
