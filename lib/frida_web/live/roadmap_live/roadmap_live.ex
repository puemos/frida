defmodule FridaWeb.RoadmapLive do
  use FridaWeb, :live_view

  @impl true
  def mount(_params, session, socket) do
    socket =
      assign_defaults(session, socket)
      |> assign_status()

    {:ok, socket}
  end

  defp assign_status(socket) do
    status =
      Frida.Posts.list_status()
      |> Enum.sort_by(fn s -> s.order end)

    socket |> assign(:status, status)
  end
end
