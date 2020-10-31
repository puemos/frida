defmodule Frida.Repo.Migrations.CreateFeedbacks do
  use Ecto.Migration

  def change do
    create table(:feedbacks) do
      add :title, :string
      add :details, :string

      timestamps()
    end

  end
end
