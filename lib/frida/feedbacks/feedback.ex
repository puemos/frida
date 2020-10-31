defmodule Frida.Feedbacks.Feedback do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feedbacks" do
    field :details, :string
    field :title, :string
    belongs_to :user, Frida.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(feedback, attrs) do
    feedback
    |> cast(attrs, [:title, :details])
    |> validate_required([:title, :details])
  end
end
