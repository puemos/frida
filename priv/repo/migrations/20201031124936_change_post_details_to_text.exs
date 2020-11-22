defmodule Frida.Repo.Migrations.ChangePostDetailsToText do
  use Ecto.Migration

  def change do
    alter table("posts") do
      modify :details, :text
    end
  end
end
