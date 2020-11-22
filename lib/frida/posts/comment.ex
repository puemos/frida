defmodule Frida.Posts.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_comments" do
    field :body, :string
    belongs_to :user, Frida.Users.User
    belongs_to :post, Frida.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :post_id])
    |> validate_required([:body])
    |> validate_required([:user_id, :post_id])
  end
end
