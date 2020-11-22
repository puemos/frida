defmodule Frida.Posts.Like do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_likes" do
    belongs_to :user, Frida.Users.User
    belongs_to :post, Frida.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
    |> unique_constraint([:user_id, :post_id], message: "only 1 like per user")
  end
end
