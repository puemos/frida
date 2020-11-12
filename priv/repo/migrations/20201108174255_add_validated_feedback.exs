defmodule Frida.Repo.Migrations.AddValidatedFeedback do
  use Ecto.Migration

  def change do
    alter table("feedbacks") do
      add :validated, :boolean
    end
  end
end
