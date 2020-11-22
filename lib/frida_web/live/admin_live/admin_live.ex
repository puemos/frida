defmodule FridaWeb.AdminLive do
  use FridaWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign_users()

    {:ok, socket}
  end

  defp assign_users(socket) do
    users = Frida.Users.list_users()
    socket |> assign(:users, users)
  end
end
