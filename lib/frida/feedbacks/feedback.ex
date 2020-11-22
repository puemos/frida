defmodule Frida.Feedbacks.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedbacks" do
    field :details, :string
    field :title, :string
    field :validated, :boolean, default: false

    belongs_to :user, Frida.Users.User
    has_many :likes, Frida.Feedbacks.Like
    has_many :comments, Frida.Feedbacks.Comment

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:title, :details])
    |> validate_required([:title, :details])
  end
end
