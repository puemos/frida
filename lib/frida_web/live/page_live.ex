defmodule FridaWeb.PageLive do
  use FridaWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end



  @impl true
  def render(assigns) do
    ~L'''
      <section class="container mx-auto py-24 px-4">
        <div class="w-full md:w-11/12 xl:w-8/12 mx-auto text-left md:text-center">
          <h1 class="text-4xl md:text-5xl text-gray-900 leading-tight mb-3 font-bold md:font-extrabold">
            Frida
          </h1>
          <p class="text-lg md:text-xl text-gray-600 mb-6">
            Self-hosted feedback tool, for all :)
          </p>
        </div>
      </section>
    '''
  end
end
