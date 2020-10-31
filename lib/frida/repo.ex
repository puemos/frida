defmodule Frida.Repo do
  use Ecto.Repo,
    otp_app: :frida,
    adapter: Ecto.Adapters.Postgres
end
