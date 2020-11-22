defmodule Frida.Repo.Migrations.CreatePostComments do
  use Ecto.Migration

  def change do
    create table(:post_comments) do
      add :body, :text
      add :user_id, references(:users, on_delete: :nothing)
      add :post_id, references(:posts, on_delete: :nothing)

      timestamps()
    end

    create index(:post_comments, [:user_id])
    create index(:post_comments, [:post_id])
  end
end
