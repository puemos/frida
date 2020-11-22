defmodule Frida.Repo.Migrations.UniqueConstraintOneLikePerUserAndPost do
  use Ecto.Migration

  def change do
    create unique_index(:post_likes, [:user_id, :post_id])
  end
end
