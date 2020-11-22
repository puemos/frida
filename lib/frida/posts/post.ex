defmodule Frida.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :details, :string
    field :title, :string
    field :validated, :boolean, default: false

    belongs_to :user, Frida.Users.User
    belongs_to :status, Frida.Posts.Status
    has_many :likes, Frida.Posts.Like
    has_many :comments, Frida.Posts.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :details])
    |> cast_assoc(:status)
    |> validate_required([:title, :details])
  end
end
