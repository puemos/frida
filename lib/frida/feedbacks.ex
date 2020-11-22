defmodule Frida.Feedbacks do
  @moduledoc """
  The Feedbacks context.
  """

  import Ecto.Query, warn: false
  alias Frida.Repo

  alias Frida.Feedbacks.{Feedback, Like, Comment}

  def list_feedbacks do
    Repo.all(
      from f in Feedback,
        preload: [:likes, :comments]
    )
  end

  def get_feedback!(id), do: Repo.get!(Feedback, id) |> Repo.preload([:likes, :comments, :user])

  def create_feedback(attrs \\ %{}, user) do
    %Feedback{}
    |> Feedback.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def like_feedback(feedback, user) do
    %Like{}
    |> Like.changeset(%{feedback_id: feedback.id, user_id: user.id})
    |> Repo.insert()
  end

  def create_comment_feedback(comment) do
    %Comment{}
    |> Comment.changeset(comment)
    |> Repo.insert()
  end

  def change_comment(%Comment{} = comment, attrs \\ %{}) do
    Comment.changeset(comment, attrs)
  end

  def update_feedback(%Feedback{} = feedback, attrs) do
    feedback
    |> Feedback.changeset(attrs)
    |> Repo.update()
  end

  def delete_feedback(%Feedback{} = feedback) do
    Repo.delete(feedback)
  end

  def change_feedback(%Feedback{} = feedback, attrs \\ %{}) do
    Feedback.changeset(feedback, attrs)
  end
end
