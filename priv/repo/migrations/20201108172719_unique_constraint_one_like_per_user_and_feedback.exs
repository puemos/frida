defmodule Frida.Repo.Migrations.UniqueConstraintOneLikePerUserAndFeedback do
  use Ecto.Migration

  def change do
    create unique_index(:feedback_likes, [:user_id, :feedback_id])
  end
end
