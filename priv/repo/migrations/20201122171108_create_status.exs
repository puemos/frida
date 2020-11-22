defmodule Frida.Repo.Migrations.CreateStatus do
  use Ecto.Migration

  def change do
    create table(:status) do
      add :name, :string
      add :color, :string
      add :order, :integer

      timestamps()
    end

  end
end
