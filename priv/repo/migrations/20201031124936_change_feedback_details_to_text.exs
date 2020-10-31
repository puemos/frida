defmodule Frida.Repo.Migrations.ChangeFeedbackDetailsToText do
  use Ecto.Migration

  def change do
    alter table("feedbacks") do
      modify :details, :text
    end
  end
end
