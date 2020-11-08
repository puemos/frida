defmodule Frida.Repo.Migrations.CreateFeedbackLikes do
  use Ecto.Migration

  def change do
    create table(:feedback_likes) do
      add :user_id, references(:users, on_delete: :nothing)
      add :feedback_id, references(:feedbacks, on_delete: :nothing)

      timestamps()
    end

    create index(:feedback_likes, [:user_id])
    create index(:feedback_likes, [:feedback_id])
  end
end
