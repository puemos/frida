defmodule FridaWeb.FeedbackDetailsLive.FormComponent do
  use FridaWeb, :live_component

  alias Frida.Feedbacks
  alias Frida.Feedbacks.{Comment}

  @impl true
  def update(assigns, socket) do
    changeset = Feedbacks.change_comment(%Comment{})

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  # @impl true
  # def handle_event("validate", %{"comment" => comment_params}, socket) do
  #   changeset =
  #     socket.assigns.comment_params
  #     |> Feedbacks.comment_feedback()
  #     |> Map.put(:action, :validate)

  #   {:noreply, assign(socket, :changeset, changeset)}
  # end

  def handle_event("save", %{"comment" => comment_params}, socket) do
    save_comment(socket, comment_params)
  end

  defp save_comment(socket, comment_params) do
    case Feedbacks.create_comment_feedback(comment_params) do
      {:ok, _comment} ->
        changeset = Feedbacks.change_comment(%Comment{})
        send(self(), {:load, comment_params.feedback_id})

        {:noreply,
         socket
         |> assign(:changeset, changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
