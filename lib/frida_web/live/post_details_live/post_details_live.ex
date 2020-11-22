defmodule FridaWeb.PostDetailsLive do
  use FridaWeb, :live_view

  alias Frida.Posts
  alias Frida.Posts.Post

  @impl true
  def mount(params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign_post(params["id"])

    {:ok, socket}
  end

  @impl true
  def handle_info({:load, id}, socket) do
    socket = assign_post(socket, id)
    {:noreply, socket}
  end

  defp assign_post(socket, id) do
    post = Posts.get_post!(id)
    assign(socket, :post, post)
  end
end
