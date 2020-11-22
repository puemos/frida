defmodule Frida.Repo.Migrations.CreateFeedbackComments do
  use Ecto.Migration

  def change do
    create table(:feedback_comments) do
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :feedback_id, references(:feedbacks, on_delete: :nothing)

      timestamps()
    end

    create index(:feedback_comments, [:user_id])
    create index(:feedback_comments, [:feedback_id])
  end
end
