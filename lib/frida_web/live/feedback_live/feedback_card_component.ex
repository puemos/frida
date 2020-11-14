defmodule FridaWeb.FeedbackLive.FeedbackCardComponent do
  use FridaWeb, :live_component

  @impl true
  def handle_event("like", _params, socket) do
    send(self(), {:like, socket.assigns.feedback})
    {:noreply, socket}
  end

  @impl true
  def handle_event("show", _params, socket) do
    send(self(), {:show, socket.assigns.feedback})
    {:noreply, socket}
  end


  def count_likes(likes) do
    Enum.count(likes) |> Integer.to_string()
  end
end
