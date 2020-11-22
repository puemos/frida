defmodule Frida.Repo.Migrations.AddValidatedPost do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :validated, :boolean
    end
  end
end
