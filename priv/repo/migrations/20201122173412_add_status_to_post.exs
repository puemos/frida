defmodule Frida.Repo.Migrations.AddStatusToPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :status_id, references(:status, on_delete: :nothing)
    end
  end
end
