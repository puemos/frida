defmodule Frida.Feedbacks.Like do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedback_likes" do
    belongs_to :user, Frida.Users.User
    belongs_to :feedback, Frida.Feedbacks.Feedback

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:user_id, :feedback_id])
    |> validate_required([:user_id, :feedback_id])
    |> unique_constraint([:user_id, :feedback_id], message: "only 1 like per user")
  end
end
