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
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
