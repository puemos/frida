defmodule FridaWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  use Phoenix.LiveView
  alias FridaWeb.Credentials

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

  def assign_defaults(session, socket) do
    socket =
      assign_new(socket, :current_user, fn ->
        Credentials.get_user(socket, session)
      end)

    if socket.assigns.current_user do
      socket
    else
      redirect(socket, to: "/session/new")
    end
  end

  @spec count(list()) :: binary
  def count(enumerable) do
    Enum.count(enumerable) |> Integer.to_string()
  end
end
