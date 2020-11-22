defmodule FridaWeb.HomeLive do
  use FridaWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    {:ok, socket}
  end
end
