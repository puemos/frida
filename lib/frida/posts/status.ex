defmodule Frida.Posts.Status do
  use Ecto.Schema
  import Ecto.Changeset

  schema "status" do
    field :color, :string
    field :name, :string
    field :order, :integer

    has_many :posts, Frida.Posts.Post


    timestamps()
  end

  @doc false
  def changeset(status, attrs) do
    status
    |> cast(attrs, [:name, :color, :order])
    |> validate_required([:name, :color, :order])
  end
end
