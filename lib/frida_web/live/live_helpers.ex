defmodule FridaWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers
  use Phoenix.LiveView
  alias FridaWeb.Credentials
  alias FridaWeb.Router.Helpers, as: Routes

  @doc """
  Renders a component inside the `FridaWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, FridaWeb.PostLive.FormComponent,
        id: @post.id || :new,
        action: @live_action,
        post: @post,
        return_to: Routes.post_index_path(@socket, :index) %>
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
      redirect(socket, to: Routes.pow_session_path(socket, :new))
    end
  end

  @spec count(list()) :: binary
  def count(enumerable) do
    Enum.count(enumerable) |> Integer.to_string()
  end

  @spec is_admin?(Frida.Users.User.t()) :: boolean()
  def is_admin?(%{role: "admin"}), do: true
  def is_admin?(_any), do: false

  @spec humanize_date(DateTime.t()) :: String.t()
  def humanize_date(date) do
    "#{date.day}/#{date.month}/#{date.year} #{date.hour}:#{date.minute}"
  end
end
