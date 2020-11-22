defmodule FridaWeb.FeedbackLive.Show do
  use FridaWeb, :live_view

  alias Frida.Feedbacks

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:feedback, Feedbacks.get_feedback!(id))}
  end


end
