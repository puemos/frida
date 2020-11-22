defmodule FridaWeb.Router do
  use FridaWeb, :router
  use Pow.Phoenix.Router

  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowEmailConfirmation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FridaWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: FridaWeb.Telemetry
    end
  end

  scope "/" do
    pipe_through [:browser]
    pow_routes()
    pow_extension_routes()
  end

  scope "/", FridaWeb do
    pipe_through [:browser]
    live "/", HomeLive
  end

  ## Authentication routes
  scope "/", FridaWeb do
    pipe_through [:browser, :protected]

    live "/feedbacks", FeedbacksLive
    live "/feedbacks/:id", FeedbackDetailsLive
  end
end
