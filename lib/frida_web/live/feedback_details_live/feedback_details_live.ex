defmodule FridaWeb.FeedbackDetailsLive do
  use FridaWeb, :live_view

  alias Frida.Feedbacks
  alias Frida.Feedbacks.Feedback

  @impl true
  def mount(params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign_feedback(params["id"])

    {:ok, socket}
  end

  @impl true
  def handle_info({:load, id}, socket) do
    socket = assign_feedback(socket, id)
    {:noreply, socket}
  end

  defp assign_feedback(socket, id) do
    feedback = Feedbacks.get_feedback!(id)
    IO.inspect(feedback)
    assign(socket, :feedback, feedback)
  end
end
