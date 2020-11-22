defmodule FridaWeb.PostLive.FormComponent do
  use FridaWeb, :live_component

  alias Frida.Posts

  @impl true
  def update(%{post: post} = assigns, socket) do
    changeset = Posts.change_post(post)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"post" => post_params}, socket) do
    changeset =
      socket.assigns.post
      |> Posts.change_post(post_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    save_post(socket, socket.assigns.action, post_params)
  end

  defp save_post(socket, :new, post_params) do
    case Posts.create_post(post_params, socket.assigns.current_user) do
      {:ok, _post} ->
        changeset = Posts.change_post(%Frida.Posts.Post{})

        {:noreply,
         socket
         |> put_flash(:info, "Post created successfully")
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
