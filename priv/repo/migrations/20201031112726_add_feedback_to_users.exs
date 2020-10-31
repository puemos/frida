defmodule Frida.Repo.Migrations.AddFeedbackToUsers do
  use Ecto.Migration

  def change do
    alter table("feedbacks") do
      add :user_id, references(:users)
    end
  end
end
