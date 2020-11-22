defmodule FridaWeb.PostDetailsLive.FormComponent do
  use FridaWeb, :live_component

  alias Frida.Posts
  alias Frida.Posts.{Comment}

  @impl true
  def update(assigns, socket) do
    changeset = Posts.change_comment(%Comment{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  # @impl true
  # def handle_event("validate", %{"comment" => comment_params}, socket) do
  #   changeset =
  #     socket.assigns.comment_params
  #     |> Posts.comment_post()
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign(socket, :changeset, changeset)}
  # end

  def handle_event("save", %{"comment" => comment_params}, socket) do
    save_comment(socket, comment_params)
  end

  defp save_comment(socket, comment_params) do
    case Posts.create_comment_post(comment_params) do
      {:ok, _comment} ->
        changeset = Posts.change_comment(%Comment{})
        send(self(), {:load, comment_params.post_id})

        {:noreply,
         socket
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
