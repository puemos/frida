defmodule FridaWeb.StatusLive.Index do
  use FridaWeb, :live_view

  alias Frida.Posts
  alias Frida.Posts.Status

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :status_collection, list_status())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Status")
    |> assign(:status, Posts.get_status!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Status")
    |> assign(:status, %Status{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Status")
    |> assign(:status, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    status = Posts.get_status!(id)
    {:ok, _} = Posts.delete_status(status)

    {:noreply, assign(socket, :status_collection, list_status())}
  end

  defp list_status do
    Posts.list_status()
  end
end
