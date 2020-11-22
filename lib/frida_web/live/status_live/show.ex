defmodule FridaWeb.StatusLive.Show do
  use FridaWeb, :live_view

  alias Frida.Posts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:status, Posts.get_status!(id))}
  end

  defp page_title(:show), do: "Show Status"
  defp page_title(:edit), do: "Edit Status"
end
