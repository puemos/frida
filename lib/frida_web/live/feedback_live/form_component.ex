defmodule FridaWeb.FeedbackLive.FormComponent do
  use FridaWeb, :live_component

  alias Frida.Feedbacks

  @impl true
  def update(%{feedback: feedback} = assigns, socket) do
    changeset = Feedbacks.change_feedback(feedback)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true

  def handle_event("save", %{"feedback" => feedback_params}, socket) do
    save_feedback(socket, socket.assigns.action, feedback_params)
  end

  defp save_feedback(socket, :new, feedback_params) do
    case Feedbacks.create_feedback(feedback_params, socket.assigns.current_user) do
      {:ok, _feedback} ->
        changeset = Feedbacks.change_feedback(%Frida.Feedbacks.Feedback{})

        {:noreply,
         socket
         |> put_flash(:info, "Feedback created successfully")
         |> assign(:changeset, changeset)
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
