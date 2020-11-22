defmodule Frida.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :details, :string

      timestamps()
    end

  end
end
