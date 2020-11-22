defmodule FridaWeb.PostsLive do
  use FridaWeb, :live_view

  alias Frida.Posts
  alias Frida.Posts.Post

  @impl true
  def mount(_params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign(:post, %Post{})
      |> assign_posts()

    {:ok, socket}
  end

  @impl true
  def handle_info({:like, post}, socket) do
    Frida.Posts.like_post(post, socket.assigns.current_user)
    socket = assign_posts(socket)
    {:noreply, socket}
  end

  defp assign_posts(socket) do
    posts = Posts.list_posts()
    assign(socket, :posts, posts)
  end
end
