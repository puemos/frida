defmodule FridaWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  use Phoenix.LiveView

  @doc """
  Renders a component inside the `FridaWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, FridaWeb.FeedbackLive.FormComponent,
        id: @feedback.id || :new,
        action: @live_action,
        feedback: @feedback,
        return_to: Routes.feedback_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, FridaWeb.ModalComponent, modal_opts)
  end

  def assign_defaults(%{"user_token" => user_token}, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Frida.Accounts.get_user_by_session_token(user_token)
      end)

    if socket.assigns.current_user.confirmed_at do
      socket
    else
      redirect(socket, to: "/login")
    end
  end
end
