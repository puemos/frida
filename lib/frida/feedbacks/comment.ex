defmodule Frida.Feedbacks.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedback_comments" do
    field :body, :string
    belongs_to :user, Frida.Users.User
    belongs_to :feedback, Frida.Feedbacks.Feedback

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :feedback_id])
    |> validate_required([:body])
    |> validate_required([:user_id, :feedback_id])
  end
end
